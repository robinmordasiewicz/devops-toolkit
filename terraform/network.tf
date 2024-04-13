resource "azurerm_public_ip" "mgmt_public_ip" {
  name                = "mgmt_public_ip"
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "vip_public_ip" {
  name                = "vip_public_ip"
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

data "azurerm_public_ip" "vip_public_ip" {
  name                = azurerm_public_ip.vip_public_ip.name
  resource_group_name = azurerm_resource_group.azure_resource_group.name
}

data "azurerm_public_ip" "mgmt_public_ip" {
  name                = azurerm_public_ip.mgmt_public_ip.name
  resource_group_name = azurerm_resource_group.azure_resource_group.name
}

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
    name                       = "internal-inbound-allow-tcp-443_rule"
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
    name                       = "MGMT-allow-https_inbound_rule"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = data.azurerm_public_ip.mgmt_public_ip.ip_address
  }
  security_rule {
    name              = "VIP-allow_http"
    priority          = 101
    direction         = "Inbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    #checkov:skip=CKV_AZURE_160: Allow port 80 for HTTPS redirect
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = data.azurerm_public_ip.vip_public_ip.ip_address
  }
  security_rule {
    name                       = "VIP-allow_https"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = data.azurerm_public_ip.vip_public_ip.ip_address
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

output "vip_public_ip_address" {
  description = "VIP IP address"
  value       = data.azurerm_public_ip.vip_public_ip.ip_address
}

output "mgmt_public_ip_address" {
  description = "Management IP address"
  value       = data.azurerm_public_ip.mgmt_public_ip.ip_address
}
