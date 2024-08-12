resource "azurerm_virtual_network" "spoke_virtual_network" {
  name                = "spoke_virtual_network"
  address_space       = [var.spoke-virtual-network_address_prefix]
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name
}

resource "azurerm_virtual_network_peering" "spoke-to-hub_virtual_network_peering" {
  name                      = "spoke-to-hub_virtual_network_peering"
  resource_group_name       = azurerm_resource_group.azure_resource_group.name
  virtual_network_name      = azurerm_virtual_network.spoke_virtual_network.name
  remote_virtual_network_id = azurerm_virtual_network.hub_virtual_network.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true
  depends_on                = [azurerm_virtual_network.hub_virtual_network, azurerm_virtual_network.spoke_virtual_network]
}

resource "azurerm_subnet" "spoke_subnet" {
  address_prefixes     = [var.spoke-subnet_prefix]
  name                 = var.spoke-subnet_name
  resource_group_name  = azurerm_resource_group.azure_resource_group.name
  virtual_network_name = azurerm_virtual_network.spoke_virtual_network.name
}

resource "azurerm_subnet" "spoke_aks_subnet" {
  address_prefixes     = [var.spoke-aks-subnet_prefix]
  name                 = var.spoke-aks-subnet_name
  resource_group_name  = azurerm_resource_group.azure_resource_group.name
  virtual_network_name = azurerm_virtual_network.spoke_virtual_network.name
}

resource "azurerm_route_table" "spoke_route_table" {
  name                = "spoke_route_table"
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  route {
    name                   = "default"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.hub-nva-gateway
  }
}

resource "azurerm_subnet_route_table_association" "spoke-route-table_association" {
  subnet_id      = azurerm_subnet.spoke_aks_subnet.id
  route_table_id = azurerm_route_table.spoke_route_table.id
}

resource "azurerm_network_security_group" "spoke_network_security_group" {
  name                = "spoke_network_security_group"
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  security_rule { #tfsec:ignore:AVD-AZU-0047
    name              = "inbound-http_rule"
    priority          = 100
    direction         = "Inbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    #destination_port_ranges    = var.spoke-aks-node-image-gpu == true ? ["80", "81", "8080", "11434"] : ["80", "81"] #checkov:skip=CKV_AZURE_160: Allow HTTP redirects
    source_address_prefix = "*"
    #destination_address_prefix = var.spoke-aks-node-ip
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                    = "aks-node_to_internet_rule"
    priority                = 100
    direction               = "Outbound"
    access                  = "Allow"
    protocol                = "Tcp"
    source_port_range       = "*"
    destination_port_ranges = ["80", "443"]
    #source_address_prefix      = var.spoke-aks-node-ip
    #source_address_prefix = var.spoke-subnet_prefix
    source_address_prefix      = "*"
    destination_address_prefix = "*" #tfsec:ignore:AVD-AZU-0051
  }
  security_rule { #tfsec:ignore:AVD-AZU-0051
    name                   = "icmp_to_google-dns_rule"
    priority               = 101
    direction              = "Outbound"
    access                 = "Allow"
    protocol               = "Icmp"
    source_port_range      = "*"
    destination_port_range = "*"
    #source_address_prefix      = var.spoke-aks-node-ip
    #source_address_prefix = var.spoke-subnet_prefix
    source_address_prefix = "*"
    #destination_address_prefix = "8.8.8.8"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "spoke-subnet-network-security-group_association" {
  subnet_id                 = azurerm_subnet.spoke_subnet.id
  network_security_group_id = azurerm_network_security_group.spoke_network_security_group.id
}
