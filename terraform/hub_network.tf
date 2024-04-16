resource "azurerm_virtual_network" "hub_virtual_network" {
  name                = "hub_virtual_network"
  address_space       = [var.hub-virtual-network_address_prefix]
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name
}

resource "azurerm_virtual_network_peering" "hub-to-spoke_virtual_network_peering" {
  name                      = "hub-to-spoke_virtual_network_peering"
  resource_group_name       = azurerm_resource_group.azure_resource_group.name
  virtual_network_name      = azurerm_virtual_network.hub_virtual_network.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_virtual_network.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true
}

resource "azurerm_subnet" "hub-external_subnet" {
  address_prefixes     = [var.hub-external-subnet_prefix]
  name                 = var.hub-external-subnet_name
  resource_group_name  = azurerm_resource_group.azure_resource_group.name
  virtual_network_name = azurerm_virtual_network.hub_virtual_network.name
}

resource "azurerm_subnet" "hub-internal_subnet" {
  address_prefixes     = [var.hub-internal-subnet_prefix]
  name                 = var.hub-internal-subnet_name
  resource_group_name  = azurerm_resource_group.azure_resource_group.name
  virtual_network_name = azurerm_virtual_network.hub_virtual_network.name
}

resource "azurerm_route_table" "hub_route_table" {
  name                          = "hub_route_table"
  location                      = azurerm_resource_group.azure_resource_group.location
  resource_group_name           = azurerm_resource_group.azure_resource_group.name
  disable_bgp_route_propagation = false

  route {
    name           = "default"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }
}

resource "azurerm_subnet_route_table_association" "hub-internal-routing-table_association" {
  subnet_id      = azurerm_subnet.hub-internal_subnet.id
  route_table_id = azurerm_route_table.hub_route_table.id
}

resource "azurerm_subnet_route_table_association" "hub-external-route-table_association" {
  subnet_id      = azurerm_subnet.hub-external_subnet.id
  route_table_id = azurerm_route_table.hub_route_table.id
}

resource "azurerm_network_security_group" "hub-external_network_security_group" { #tfsec:ignore:azure-network-no-public-ingress
  name                = "hub-external_network_security_group"
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  security_rule {
    name                       = "MGMT_rule"
    priority                   = 100
    direction                  = "Inbound"
    access                     = var.hub-nva-management-action
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.hub-nva-management-port
    source_address_prefix      = "*"
    destination_address_prefix = cidrhost(var.hub-external-subnet_prefix, 4)
  }
  security_rule {
    name                       = "VIP_rule"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["80", "443"] #checkov:skip=CKV_AZURE_160: Allow HTTP redirects
    source_address_prefix      = "*"
    destination_address_prefix = cidrhost(var.hub-external-subnet_prefix, 100)
  }
}

resource "azurerm_subnet_network_security_group_association" "hub-external-subnet-network-security-group_association" {
  subnet_id                 = azurerm_subnet.hub-external_subnet.id
  network_security_group_id = azurerm_network_security_group.hub-external_network_security_group.id
}

resource "azurerm_network_security_group" "hub-internal_network_security_group" {
  name                = "hub-internal_network_security_group"
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  security_rule {
    name                       = "container-server_to_internet_rule"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["80", "443"]
    source_address_prefix      = cidrhost(var.spoke-subnet_prefix, 5)
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "icmp_to_google-dns_rule"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = cidrhost(var.spoke-subnet_prefix, 5)
    destination_address_prefix = "8.8.8.8"
  }
  security_rule {
    name                       = "outbound-http_rule"
    priority                   = 102
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["80", "81"]
    source_address_prefix      = "*"
    destination_address_prefix = cidrhost(var.spoke-subnet_prefix, 5)
  }
}

resource "azurerm_subnet_network_security_group_association" "hub-internal-subnet-network-security-group_association" {
  subnet_id                 = azurerm_subnet.hub-internal_subnet.id
  network_security_group_id = azurerm_network_security_group.hub-internal_network_security_group.id
}

resource "azurerm_public_ip" "hub-nva-management_public_ip" {
  name                = "hub-nva-management_public_ip"
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "nva"
}

resource "azurerm_public_ip" "hub-nva-vip_public_ip" {
  name                = "hub-nva-vip_public_ip"
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "dvwa"
}

resource "azurerm_network_interface" "hub-nva-external_network_interface" {
  name                          = "hub-nva-external_network_interface"
  location                      = azurerm_resource_group.azure_resource_group.location
  resource_group_name           = azurerm_resource_group.azure_resource_group.name
  enable_accelerated_networking = true
  ip_configuration {
    name                          = "hub-nva-management-external_ip_configuration"
    primary                       = true
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub-external-subnet_prefix, 4)
    subnet_id                     = azurerm_subnet.hub-external_subnet.id
    public_ip_address_id          = azurerm_public_ip.hub-nva-management_public_ip.id #checkov:skip=CKV_AZURE_119:Fortigate gets a public IP
  }
  ip_configuration {
    name                          = "hub-nva-vip-external-ip_configuration"
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub-external-subnet_prefix, 100)
    subnet_id                     = azurerm_subnet.hub-external_subnet.id
    public_ip_address_id          = azurerm_public_ip.hub-nva-vip_public_ip.id #checkov:skip=CKV_AZURE_119:Fortigate gets a public IP
  }
}

resource "azurerm_network_interface" "hub-nva-internal_network_interface" {
  name                          = "hub-nva-internal_network_interface"
  location                      = azurerm_resource_group.azure_resource_group.location
  resource_group_name           = azurerm_resource_group.azure_resource_group.name
  enable_accelerated_networking = true
  enable_ip_forwarding          = true #checkov:skip=CKV_AZURE_118:Fortigate NIC needs IP forwarding.
  ip_configuration {
    name                          = "hub-nva-internal_ip_configuration"
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.hub-internal-subnet_prefix, 4)
    subnet_id                     = azurerm_subnet.hub-internal_subnet.id
  }
}
