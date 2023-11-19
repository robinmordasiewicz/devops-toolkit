resource "azurerm_availability_set" "fortinet_availability_set" {
  location                     = azurerm_resource_group.azure_resource_group.location
  resource_group_name          = azurerm_resource_group.azure_resource_group.name
  name                         = "fortinet_availability_set"
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
}
