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

resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                              = "kubernetes_cluster"
  location                          = azurerm_resource_group.azure_resource_group.location
  resource_group_name               = azurerm_resource_group.azure_resource_group.name
  dns_prefix                        = azurerm_resource_group.azure_resource_group.name
  kubernetes_version                = data.azurerm_kubernetes_service_versions.current.latest_version
  sku_tier                          = "Standard"
  node_resource_group               = "MC-${azurerm_resource_group.azure_resource_group.name}"
  role_based_access_control_enabled = true
  oidc_issuer_enabled               = true
  workload_identity_enabled         = true
  api_server_access_profile {
    authorized_ip_ranges = [
      "${chomp(data.http.myip.response_body)}/32"
    ]
  }
  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics.id
  }
  default_node_pool {
    temporary_name_for_rotation = "rotation"
    name                        = "default"
    node_count                  = 1
    vm_size                     = "Standard_B4ms"
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
    type = "SystemAssigned"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "node-pool" {
  name                  = "gpu"
  mode                  = "User"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.kubernetes_cluster.id
  depends_on            = [azurerm_kubernetes_cluster.kubernetes_cluster]
  vm_size               = "Standard_NC6s_v3" #16GB
  #vm_size               = "Standard_NC24s_v3"
  #vm_size               = "Standard_NC4as_T4_v3" # 16GB
  #vm_size               = "Standard_ND40rs_v2" # 32 GB vlink
  #vm_size               = "Standard_NC24ads_A100_v4" # 80GB
  node_count        = 1
  os_sku            = "AzureLinux"
  node_taints       = ["nvidia.com/gpu=true:NoSchedule"]
  os_disk_type      = "Ephemeral"
  ultra_ssd_enabled = true
  os_disk_size_gb   = "256"
  max_pods          = "50"
  zones             = ["1"]
}

resource "azurerm_kubernetes_cluster_extension" "flux_extension" {
  name              = "flux-extension"
  cluster_id        = azurerm_kubernetes_cluster.kubernetes_cluster.id
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
  name                              = "flux-configuration"
  cluster_id                        = azurerm_kubernetes_cluster.kubernetes_cluster.id
  namespace                         = "cluster-config"
  scope                             = "cluster"
  continuous_reconciliation_enabled = true
  git_repository {
    url                      = "https://github.com/robinmordasiewicz/devops-toolkit"
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
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config_raw
  sensitive   = true
}

resource "local_file" "kube_config" {
  content              = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config_raw
  filename             = "/home/vscode/.kube/config.yaml"
  directory_permission = "0755"
  file_permission      = "0600"
}
