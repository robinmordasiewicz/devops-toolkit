resource "azurerm_subnet_network_security_group_association" "external_association" {
  subnet_id                 = azurerm_subnet.external_subnet.id
  network_security_group_id = azurerm_network_security_group.external_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "internal_association" {
  subnet_id                 = azurerm_subnet.internal_subnet.id
  network_security_group_id = azurerm_network_security_group.internal_nsg.id
}

resource "azurerm_network_security_group" "internal_nsg" { #tfsec:ignore:azure-network-no-public-ingress
  name                = "internal_nsg"
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  security_rule {
    name                       = "internal-allow_https_tcp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["443"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "external_nsg" { #tfsec:ignore:azure-network-no-public-ingress
  name                = "external_nsg"
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  security_rule {
    name                       = "MGMT-allow_https_tcp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["443"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "VIP-allow_https_tcp"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["443"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

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
