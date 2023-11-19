resource "azurerm_resource_group" "azure_resource_group" {
  #ts:skip=AC_AZURE_0389 in development we allow deletion of resource groups
  name     = var.resource_group
  location = var.location
  tags = {
    Username = var.owner_email
  }
}
