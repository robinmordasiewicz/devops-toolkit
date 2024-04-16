resource "azurerm_availability_set" "hub-nva_availability_set" {
  location                     = azurerm_resource_group.azure_resource_group.location
  resource_group_name          = azurerm_resource_group.azure_resource_group.name
  name                         = "hub-nva_availability_set"
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
}

resource "azurerm_resource_group" "azure_resource_group" {
  #ts:skip=AC_AZURE_0389 in development we allow deletion of resource groups
  name     = random_pet.admin_username.id
  location = var.location
  tags = {
    Username = var.owner_email
  }
}

resource "random_pet" "admin_username" {
  length = 1
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
