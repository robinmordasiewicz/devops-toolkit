resource "azurerm_subnet" "external_subnet" {
  address_prefixes     = [var.external_prefix]
  name                 = var.external_name
  resource_group_name  = azurerm_resource_group.azure_resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}
resource "azurerm_subnet" "internal_subnet" {
  address_prefixes     = [var.internal_prefix]
  name                 = var.internal_name
  resource_group_name  = azurerm_resource_group.azure_resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}
