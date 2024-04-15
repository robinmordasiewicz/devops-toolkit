resource "azurerm_availability_set" "hub-nva_availability_set" {
  location                     = azurerm_resource_group.azure_resource_group.location
  resource_group_name          = azurerm_resource_group.azure_resource_group.name
  name                         = "hub-nva_availability_set"
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
}

resource "azurerm_resource_group" "azure_resource_group" {
  #ts:skip=AC_AZURE_0389 in development we allow deletion of resource groups
  name     = var.resource_group
  location = var.location
  tags = {
    Username = var.owner_email
  }
}

resource "random_integer" "random_number" {
  min = 10000
  max = 99999
}

resource "random_pet" "admin_username" {
  keepers = {
    resource_group_name = azurerm_resource_group.azure_resource_group.name
  }
}

resource "random_password" "admin_password" {
  keepers = {
    resource_group_name = azurerm_resource_group.azure_resource_group.name
  }
  length      = 16
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  #min_special = 1
  special = false
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

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

output "tls_private_key" {
  description = "TSL private key"
  value       = tls_private_key.ssh_key.private_key_pem
  sensitive   = true
}
