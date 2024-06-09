resource "azurerm_kubernetes_cluster" "k8s" {
  location                          = azurerm_resource_group.azure_resource_group.location
  name                              = random_pet.admin_username.id
  resource_group_name               = azurerm_resource_group.azure_resource_group.name
  dns_prefix                        = random_pet.admin_username.id
  role_based_access_control_enabled = true
  service_principal {
    client_id     = random_pet.admin_username.id
    client_secret = random_password.admin_password.result
  }
  api_server_access_profile {
    authorized_ip_ranges = [
      "1.2.3.4/32"
    ]

  }
  oms_agent {
    log_analytics_workspace_id = random_pet.admin_username.id
  }

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_D2_v2"
    node_count = "1"
  }
  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
  }
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.k8s.name
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].client_certificate
  sensitive = true
}

output "client_key" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].cluster_ca_certificate
  sensitive = true
}

output "cluster_password" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].password
  sensitive = true
}

output "cluster_username" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].username
  sensitive = true
}

output "host" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].host
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config_raw
  sensitive = true
}
