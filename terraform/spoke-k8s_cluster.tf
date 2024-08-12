data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}

data "azurerm_kubernetes_service_versions" "current" {
  location        = azurerm_resource_group.azure_resource_group.location
  include_preview = false
}

resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "log-analytics"
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  sku                 = "PerGB2018"
}

resource "azurerm_user_assigned_identity" "my_identity" {
  name                = "myUserAssignedIdentity"
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  location            = azurerm_resource_group.azure_resource_group.location
}
resource "azurerm_role_assignment" "kubernetes_contributor" {
  principal_id         = azurerm_user_assigned_identity.my_identity.principal_id
  role_definition_name = "Contributor"
  scope                = azurerm_resource_group.azure_resource_group.id
}
resource "azurerm_role_assignment" "route_table_network_contributor" {
  principal_id         = azurerm_user_assigned_identity.my_identity.principal_id
  role_definition_name = "Network Contributor"
  scope                = azurerm_resource_group.azure_resource_group.id
}
resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  depends_on          = [azurerm_virtual_network_peering.spoke-to-hub_virtual_network_peering, azurerm_linux_virtual_machine.hub-nva_virtual_machine]
  name                = "spoke_kubernetes_cluster"
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  dns_prefix          = azurerm_resource_group.azure_resource_group.name
  #kubernetes_version                = data.azurerm_kubernetes_service_versions.current.latest_version
  support_plan                      = "AKSLongTermSupport"
  kubernetes_version                = "1.27"
  sku_tier                          = "Premium"
  node_resource_group               = "MC-${azurerm_resource_group.azure_resource_group.name}"
  role_based_access_control_enabled = true
  oidc_issuer_enabled               = true
  workload_identity_enabled         = true
  #api_server_access_profile {
  #  authorized_ip_ranges = [
  #    "${chomp(data.http.myip.response_body)}/32"
  #  ]
  #}
  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics.id
  }
  default_node_pool {
    temporary_name_for_rotation = "rotation"
    name                        = "default"
    node_count                  = 1
    vm_size                     = local.vm-image["aks"].size
    os_sku                      = "AzureLinux"
    max_pods                    = "75"
    vnet_subnet_id              = azurerm_subnet.spoke_subnet.id
    upgrade_settings {
      max_surge = "10%"
    }
  }
  network_profile {
    #network_plugin    = "azure"
    network_plugin = "kubenet"
    #network_plugin = "none"
    #outbound_type     = "loadBalancer" 
    #network_policy    = "azure"
    load_balancer_sku = "standard"
    #service_cidr      = var.spoke-aks-subnet_prefix
    #dns_service_ip    = var.spoke-aks_dns_service_ip
    pod_cidr = var.spoke-aks_pod_cidr
  }
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.my_identity.id]
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "node-pool" {
  count                 = var.spoke-k8s-node-pool-gpu ? 1 : 0
  name                  = "gpu"
  mode                  = "User"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.kubernetes_cluster.id
  vm_size               = local.vm-image["aks"].gpu-size
  node_count            = 1
  os_sku                = "AzureLinux"
  node_taints           = ["nvidia.com/gpu=true:NoSchedule"]
  os_disk_type          = "Ephemeral"
  ultra_ssd_enabled     = true
  os_disk_size_gb       = "256"
  max_pods              = "50"
  zones                 = ["1"]
  vnet_subnet_id        = azurerm_subnet.spoke_subnet.id
}

resource "null_resource" "kube_config" {
  triggers = {
    always_run = timestamp()
  }
  depends_on = [azurerm_kubernetes_cluster.kubernetes_cluster]
  provisioner "local-exec" {
    command = "echo \"${azurerm_kubernetes_cluster.kubernetes_cluster.kube_config_raw}\" > ~/.kube/config && chmod 600 ~/.kube/config"
  }
}

#resource "null_resource" "flannel" {
#  depends_on = [ null_resource.kube_config ]
#  provisioner "local-exec" {
#    command = "kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml"
#  }
#}

resource "azurerm_kubernetes_cluster_extension" "flux_extension" {
  name              = "flux-extension"
  cluster_id        = azurerm_kubernetes_cluster.kubernetes_cluster.id
  extension_type    = "microsoft.flux"
  release_namespace = "flux-system"
  depends_on        = [azurerm_kubernetes_cluster.kubernetes_cluster]
  configuration_settings = {
    "image-automation-controller.enabled" = true,
    "image-reflector-controller.enabled"  = true,
    "helm-controller.detectDrift"         = true,
    "notification-controller.enabled"     = true
  }
}

resource "null_resource" "secret" {
  triggers = {
    always_run = timestamp()
  }
  depends_on = [null_resource.kube_config]

  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command     = <<-EOF
      kubectl apply -f - <<EOF2
      ---
      apiVersion: v1
      kind: Namespace
      metadata:
        name: application
        labels:
          name: application
      ---
      apiVersion: v1
      kind: Secret
      metadata:
        name: fortiweb-login-secret
        namespace: application
      type: Opaque
      data:
        username: $(echo -n "${random_pet.admin_username.id}" | base64)
        password: $(echo -n "${random_password.admin_password.result}" | base64)
      EOF2
    EOF
  }
}

data "git_repository" "current" {
  path = "${path.module}/.."
}

data "external" "git_url" {
  program = ["sh", "-c", "git -C ${path.module}/.. config --get remote.origin.url | jq -R -r 'split(\"\\n\") | map(select(length > 0)) | map({url: .}) | add'"]
}

resource "azurerm_kubernetes_flux_configuration" "flux_configuration" {
  name                              = "flux-configuration"
  cluster_id                        = azurerm_kubernetes_cluster.kubernetes_cluster.id
  namespace                         = "cluster-config"
  scope                             = "cluster"
  continuous_reconciliation_enabled = true
  git_repository {
    url                      = data.external.git_url.result["url"]
    reference_type           = "branch"
    reference_value          = data.git_repository.current.branch
    sync_interval_in_seconds = 60
  }
  kustomizations {
    name                       = "infrastructure"
    recreating_enabled         = true
    garbage_collection_enabled = true
    path                       = "./manifests/infrastructure"
    sync_interval_in_seconds   = 60
  }
  kustomizations {
    name                       = "apps"
    recreating_enabled         = true
    garbage_collection_enabled = true
    path                       = "./manifests/apps"
    sync_interval_in_seconds   = 60
    depends_on                 = ["infrastructure"]
  }
  kustomizations {
    name                       = "ingress"
    recreating_enabled         = true
    garbage_collection_enabled = true
    path                       = "./manifests/ingress"
    sync_interval_in_seconds   = 60
    depends_on                 = ["apps"]
  }
  depends_on = [
    azurerm_kubernetes_cluster_extension.flux_extension
  ]
}

resource "null_resource" "openapi_file" {
  depends_on = [azurerm_kubernetes_cluster.kubernetes_cluster, azurerm_linux_virtual_machine.hub-nva_virtual_machine]
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command    = <<-EOT
TOKEN=$(echo "{\"username\":\"$USERNAME\",\"password\":\"$PASSWORD\",\"vdom\":\"root\"}" | base64 | tr -d "\\n")

#Create the swagger file
curl -k -H "Content-Type: multipart/form-data" -H "Authorization:$TOKEN" -F 'openapifile=@../manifests/apps/ollama/openapi.yaml' --insecure "https://$FQDN/api/v2.0/waf/openapi.openapischemafile" || true

# attach swagger file to new policy

curl "https://$FQDN/api/v2.0/cmdb/waf/openapi-validation-policy" \
--insecure \
-X 'POST' \
-H "Authorization:$TOKEN" \
-H 'Content-Type: application/json;charset=utf-8' \
-H 'Pragma: no-cache' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: en-US,en;q=0.9' \
-H 'Cache-Control: no-cache' \
-H 'Sec-Fetch-Mode: cors' \
-H 'Accept-Encoding: gzip, deflate, br' \
-H 'Connection: keep-alive' \
--data-binary '{"data":{"q_type":1,"name":"ollama","action":"alert","action_val":"2","block-period":600,"severity":"Low","severity_val":"3","trigger":"","trigger_val":"0","sz_schema-file":-1}}'

curl "https://$FQDN/api/v2.0/cmdb/waf/openapi-validation-policy/schema-file?mkey=ollama" \
  --insecure \
  -X 'POST' \
  -H 'Content-Type: application/json;charset=utf-8' \
  -H "Authorization:$TOKEN" \
  -H 'Pragma: no-cache' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Connection: keep-alive' \
  --data-binary '{"data":{"openapi-file":"openapi.yaml"}}'

curl "https://$FQDN/api/v2.0/cmdb/waf/openapi-validation-policy?mkey=ollama" \
  --insecure \
  -H "Authorization:$TOKEN" \
-X 'PUT' \
-H 'Content-Type: application/json;charset=utf-8' \
-H 'Pragma: no-cache' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Cache-Control: no-cache' \
-H 'Accept-Encoding: gzip, deflate, br' \
-H 'Connection: keep-alive' \
--data-binary '{"data":{"can_view":0,"q_ref":0,"can_clone":1,"q_type":1,"name":"ollama","action":"alert","action_val":"2","block-period":600,"severity":"Low","severity_val":"3","trigger":"","trigger_val":"0","sz_schema-file":0}}'

# Create Custom Policy
curl "https://$FQDN/api/v2.0/cmdb/waf/web-protection-profile.inline-protection" \
  --insecure \
  -H "Authorization:$TOKEN" \
  -X 'POST' \
  -H 'Content-Type: application/json;charset=utf-8' \
  -H 'Pragma: no-cache' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Connection: keep-alive' \
  --data-binary '{"data":{"name":"ollama","client-management":"enable","amf3-protocol-detection":"disable","mobile-app-identification":"disable","token-header":"Jwt-Token","ip-intelligence":"disable","fortigate-quarantined-ips":"disable","quarantined-ip-action":"alert","quarantined-ip-severity":"High","rdt-reason":"disable","openapi-validation-policy":"ollama"}}'
    EOT
    environment = {
      USERNAME = random_pet.admin_username.id
      PASSWORD = random_password.admin_password.result
      FQDN      = "${data.azurerm_public_ip.hub-nva-management_public_ip.fqdn}:${local.vm-image[var.hub-nva-image].management-port}"
    }
  }
}