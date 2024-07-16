data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}

data "azurerm_kubernetes_service_versions" "current" {
  for_each        = local.kubernetes_clusters
  location        = each.value.location
  include_preview = false
}

resource "azurerm_log_analytics_workspace" "log_analytics" {
  for_each            = local.kubernetes_clusters
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = "PerGB2018"
}

resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  for_each                          = local.kubernetes_clusters
  name                              = each.value.name
  location                          = each.value.location
  resource_group_name               = each.value.resource_group_name
  dns_prefix                        = "${var.prefix}-aks-${each.key}"
  kubernetes_version                = data.azurerm_kubernetes_service_versions.current[each.key].latest_version
  sku_tier                          = "Standard"
  node_resource_group               = "MC-${each.value.name}"
  role_based_access_control_enabled = true
  oidc_issuer_enabled               = true
  workload_identity_enabled         = true
  api_server_access_profile {
    authorized_ip_ranges = [
      "${chomp(data.http.myip.response_body)}/32"
    ]
  }
  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics[each.key].id
  }
  default_node_pool {
    temporary_name_for_rotation = "rotation"
    name                        = each.value.default_node_pool.name
    node_count                  = each.value.default_node_pool.node_count
    vm_size                     = each.value.default_node_pool.vm_size
    os_sku                      = "AzureLinux"
    upgrade_settings {
      max_surge = "10%"
    }
  }
  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
  }

  identity {
    type = each.value.identity.type
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "node-pool" {
  for_each              = local.kubernetes_clusters
  name                  = "gpu"
  mode                  = "User"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.kubernetes_cluster[each.key].id
  depends_on            = [azurerm_kubernetes_cluster.kubernetes_cluster]
  vm_size               = "Standard_NC6s_v3" #16GB
  #vm_size               = "Standard_NC24s_v3"
  #vm_size               = "Standard_NC4as_T4_v3" # 16GB
  #vm_size               = "Standard_ND40rs_v2" # 32 GB vlink
  #vm_size               = "Standard_NC24ads_A100_v4" # 80GB
  node_count        = 1
  os_sku            = "AzureLinux"
  node_taints       = var.user_node_pool_node_taints
  os_disk_type      = "Ephemeral"
  ultra_ssd_enabled = true
  os_disk_size_gb   = "256"
  max_pods          = "50"
  zones             = ["1"]
}

resource "azurerm_kubernetes_cluster_extension" "flux_extension" {
  for_each          = local.kubernetes_clusters
  name              = "flux-extension"
  cluster_id        = azurerm_kubernetes_cluster.kubernetes_cluster[each.key].id
  extension_type    = "microsoft.flux"
  release_namespace = "flux-system"
  depends_on        = [azurerm_kubernetes_cluster_node_pool.node-pool]
  configuration_settings = {
    "image-automation-controller.enabled" = true,
    "image-reflector-controller.enabled"  = true,
    "helm-controller.detectDrift"         = true,
    "notification-controller.enabled"     = true
  }
}

data "git_repository" "current" {
  path = "${path.module}/.."
}

resource "azurerm_kubernetes_flux_configuration" "flux_configuration" {
  for_each                          = local.kubernetes_clusters
  name                              = "flux-configuration"
  cluster_id                        = azurerm_kubernetes_cluster.kubernetes_cluster[each.key].id
  namespace                         = "cluster-config"
  scope                             = "cluster"
  continuous_reconciliation_enabled = true
  git_repository {
    url                      = var.manifest_url
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
  depends_on = [
    azurerm_kubernetes_cluster_extension.flux_extension
  ]
}

output "kube_config" {
  description = "kube config"
  value       = [for cluster in azurerm_kubernetes_cluster.kubernetes_cluster : cluster.kube_config_raw]
  sensitive   = true
}

resource "local_file" "kube_config" {
  for_each             = local.kubernetes_clusters
  content              = azurerm_kubernetes_cluster.kubernetes_cluster[each.key].kube_config_raw
  filename             = "/home/vscode/.kube/${each.value.name}.yaml"
  directory_permission = "0755"
  file_permission      = "0600"
}
