resource "azurerm_network_security_group" "nsg" { #tfsec:ignore:azure-network-no-public-ingress
  #checkov:skip=CKV_AZURE_160: Port 80 and 443 are open the internet
  name                = "nsg"
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name

  security_rule {
    name                       = "allow_http-https_tcp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["80", "443"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
