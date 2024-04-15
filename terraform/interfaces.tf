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

resource "azurerm_network_interface" "spoke-container-server_network_interface" {
  name                          = "spoke-container-server_network_interface"
  location                      = azurerm_resource_group.azure_resource_group.location
  resource_group_name           = azurerm_resource_group.azure_resource_group.name
  enable_accelerated_networking = true
  ip_configuration {
    name                          = "spoke-container-server_ip_configuration"
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.spoke-subnet_prefix, 5)
    subnet_id                     = azurerm_subnet.spoke_subnet.id
  }
}
