data "azurerm_public_ip" "hub-nva-vip_public_ip" {
  name                = azurerm_public_ip.hub-nva-vip_public_ip.name
  resource_group_name = azurerm_resource_group.azure_resource_group.name
}

data "azurerm_public_ip" "hub-nva-management_public_ip" {
  name                = azurerm_public_ip.hub-nva-management_public_ip.name
  resource_group_name = azurerm_resource_group.azure_resource_group.name
}

output "management_fqdn" {
  description = "Management FQDN"
  value       = "https://${data.azurerm_public_ip.hub-nva-management_public_ip.fqdn}:${local.vm-image[var.hub-nva-image].management-port}"

}

output "vip_fqdn" {
  description = "VIP FQDN"
  value       = "https://${data.azurerm_public_ip.hub-nva-vip_public_ip.fqdn}"
}

output "admin_username" {
  description = "Username for admin account"
  value       = random_pet.admin_username.id
}

output "admin_password" {
  description = "Password for admin account"
  value       = random_password.admin_password.result
  sensitive   = true
}
