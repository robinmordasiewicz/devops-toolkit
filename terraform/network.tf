resource "azurerm_virtual_network_peering" "hub_peer" {
  name                      = "hub_to_spoke"
  resource_group_name       = azurerm_resource_group.azure_resource_group.name
  virtual_network_name      = azurerm_virtual_network.hub-vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spoke-vnet.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true
}

resource "azurerm_virtual_network_peering" "spoke_peer" {
  name                      = "spoke_to_hub"
  resource_group_name       = azurerm_resource_group.azure_resource_group.name
  virtual_network_name      = azurerm_virtual_network.spoke-vnet.name
  remote_virtual_network_id = azurerm_virtual_network.hub-vnet.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true
}

resource "azurerm_route_table" "hub-route_table" {
  name                          = "hub-route_table"
  location                      = azurerm_resource_group.azure_resource_group.location
  resource_group_name           = azurerm_resource_group.azure_resource_group.name
  disable_bgp_route_propagation = false

  route {
    name           = "default"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }
}

resource "azurerm_subnet_route_table_association" "hub-internal-routing_table_association" {
  subnet_id      = azurerm_subnet.internal_subnet.id
  route_table_id = azurerm_route_table.hub-route_table.id
  depends_on     = [azurerm_subnet.internal_subnet]
}

resource "azurerm_subnet_route_table_association" "hub-external-routing_table_association" {
  subnet_id      = azurerm_subnet.external_subnet.id
  route_table_id = azurerm_route_table.hub-route_table.id
  depends_on     = [azurerm_subnet.external_subnet]
}

resource "azurerm_route_table" "spoke-route_table" {
  name                          = "spoke-route_table"
  location                      = azurerm_resource_group.azure_resource_group.location
  resource_group_name           = azurerm_resource_group.azure_resource_group.name
  disable_bgp_route_propagation = false

  route {
    name                   = "default"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.0.2.4"
  }
}

resource "azurerm_subnet_route_table_association" "spoke-routing_table_association" {
  subnet_id      = azurerm_subnet.spoke_subnet.id
  route_table_id = azurerm_route_table.spoke-route_table.id
  depends_on     = [azurerm_subnet.spoke_subnet]
}

# kics-scan disable=b4cc2c52-34a6-4b43-b57c-4bdeb4514a5a
resource "azurerm_virtual_network" "hub-vnet" {
  address_space       = [var.hub-vnet_address_prefix]
  name                = "hub-vnet"
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name
}

resource "azurerm_virtual_network" "spoke-vnet" {
  address_space       = [var.spoke-vnet_address_prefix]
  name                = "spoke-vnet"
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name
}

resource "azurerm_public_ip" "mgmt_public_ip" {
  name                = "mgmt_public_ip"
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "fortigate"
}

resource "azurerm_public_ip" "vip_public_ip" {
  name                = "vip_public_ip"
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "dvwa"
}

resource "azurerm_subnet_network_security_group_association" "external_association" {
  subnet_id                 = azurerm_subnet.external_subnet.id
  network_security_group_id = azurerm_network_security_group.external_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "internal_association" {
  subnet_id                 = azurerm_subnet.internal_subnet.id
  network_security_group_id = azurerm_network_security_group.internal_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "spoke_association" {
  subnet_id                 = azurerm_subnet.spoke_subnet.id
  network_security_group_id = azurerm_network_security_group.spoke_nsg.id
}

resource "azurerm_network_security_group" "external_nsg" { #tfsec:ignore:azure-network-no-public-ingress
  name                = "external_nsg"
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  security_rule {
    name                       = "MGMT-allow_rule"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = cidrhost(var.external-subnet_prefix, 4)
  }
  security_rule {
    name                       = "VIP-allow_rule"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["80", "443"]
    source_address_prefix      = "*"
    destination_address_prefix = cidrhost(var.external-subnet_prefix, 100)
  }
  security_rule {
    name                       = "outbound-allow_rule"
    priority                   = 103
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "internal_nsg" { #tfsec:ignore:azure-network-no-public-ingress
  name                = "internal_nsg"
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  security_rule {
    name                       = "inbound-allow_rule"
    priority                   = 104
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "outbound-allow_rule"
    priority                   = 105
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "spoke_nsg" { #tfsec:ignore:azure-network-no-public-ingress
  name                = "spoke_nsg"
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  security_rule {
    name                       = "inbound-allow-tcp-80_rule"
    priority                   = 106
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "outbound-allow_rule"
    priority                   = 107
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet" "external_subnet" {
  address_prefixes     = [var.external-subnet_prefix]
  name                 = var.external-subnet_name
  resource_group_name  = azurerm_resource_group.azure_resource_group.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
}

resource "azurerm_subnet" "internal_subnet" {
  address_prefixes     = [var.internal-subnet_prefix]
  name                 = var.internal-subnet_name
  resource_group_name  = azurerm_resource_group.azure_resource_group.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
}

resource "azurerm_subnet" "spoke_subnet" {
  address_prefixes     = [var.spoke-subnet_prefix]
  name                 = var.spoke-subnet_name
  resource_group_name  = azurerm_resource_group.azure_resource_group.name
  virtual_network_name = azurerm_virtual_network.spoke-vnet.name
}

data "azurerm_public_ip" "vip_public_ip" {
  name                = azurerm_public_ip.vip_public_ip.name
  resource_group_name = azurerm_resource_group.azure_resource_group.name
}

data "azurerm_public_ip" "mgmt_public_ip" {
  name                = azurerm_public_ip.mgmt_public_ip.name
  resource_group_name = azurerm_resource_group.azure_resource_group.name
}

output "vip_public_ip_address" {
  description = "VIP IP address"
  value       = data.azurerm_public_ip.vip_public_ip.ip_address
}

output "mgmt_public_ip_address" {
  description = "Management IP address"
  value       = data.azurerm_public_ip.mgmt_public_ip.ip_address
}

output "mgmt_fqdn" {
  description = "Management FQDN"
  value       = "https://${data.azurerm_public_ip.mgmt_public_ip.fqdn}"
}

output "vip_fqdn" {
  description = "VIP FQDN"
  value       = "https://${data.azurerm_public_ip.vip_public_ip.fqdn}"
}
