resource "azurerm_network_security_group" "private_nsg" {
  name                = "private_nsg"
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  security_rule {
    name                       = "block-all-in"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "block-all-out"
    priority                   = 101
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_subnet_network_security_group_association" "external_subnet_association" {
  subnet_id                 = azurerm_subnet.external_subnet.id
  network_security_group_id = azurerm_network_security_group.private_nsg.id
}
resource "azurerm_subnet_network_security_group_association" "dmz_subnet_association" {
  subnet_id                 = azurerm_subnet.dmz_subnet.id
  network_security_group_id = azurerm_network_security_group.private_nsg.id
}
resource "azurerm_subnet_network_security_group_association" "internal_subnet_association" {
  subnet_id                 = azurerm_subnet.internal_subnet.id
  network_security_group_id = azurerm_network_security_group.private_nsg.id
}

resource "azurerm_subnet" "external_subnet" {
  address_prefixes     = [var.external_prefix]
  name                 = var.external_name
  resource_group_name  = azurerm_resource_group.azure_resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}
resource "azurerm_subnet" "dmz_subnet" {
  address_prefixes     = [var.dmz_prefix]
  name                 = var.dmz_name
  resource_group_name  = azurerm_resource_group.azure_resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}
resource "azurerm_subnet" "internal_subnet" {
  address_prefixes     = [var.internal_prefix]
  name                 = var.internal_name
  resource_group_name  = azurerm_resource_group.azure_resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}
