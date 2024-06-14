data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}

data "azurerm_kubernetes_service_versions" "current" {
  location        = azurerm_resource_group.azure_resource_group.location
  include_preview = false
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                              = random_pet.admin_username.id
  sku_tier                          = "Standard"
  resource_group_name               = azurerm_resource_group.azure_resource_group.name
  location                          = azurerm_resource_group.azure_resource_group.location
  dns_prefix                        = random_pet.admin_username.id
  kubernetes_version                = data.azurerm_kubernetes_service_versions.current.latest_version
  role_based_access_control_enabled = true
  api_server_access_profile {
    authorized_ip_ranges = [
      "${chomp(data.http.myip.response_body)}/32"
    ]

  }
  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.log-analytics.id
  }

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    temporary_name_for_rotation = "rotation"
    name                        = "agentpool"
    vm_size                     = "Standard_F16s_v2"
    node_count                  = "1"
  }
  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
  }
}

resource "azurerm_log_analytics_workspace" "log-analytics" {
  name                = "log-analytics"
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  location            = azurerm_resource_group.azure_resource_group.location
  sku                 = "PerGB2018"
}

resource "azurerm_kubernetes_cluster_extension" "flux-extension" {
  name           = "flux-extension"
  cluster_id     = azurerm_kubernetes_cluster.k8s.id
  extension_type = "microsoft.flux"
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config_raw
  sensitive = true
}

resource "local_file" "kubeconfig" {
  depends_on = [azurerm_kubernetes_cluster.k8s]
  filename   = "~/.kube/config"
  content    = azurerm_kubernetes_cluster.k8s.kube_config_raw
}
