# Create network interface
resource "azurerm_network_interface" "ubuntu_dmz_network_interface" {
  name                = "ubuntu_dmz_network_interface"
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name

  ip_configuration {
    name                          = "ubuntu-dmz-ipconfig"
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.dmz_prefix, 5)
    subnet_id                     = azurerm_subnet.dmz_subnet.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "ubuntu_association" {
  network_interface_id      = azurerm_network_interface.ubuntu_dmz_network_interface.id
  network_security_group_id = azurerm_network_security_group.private_nsg.id
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "ubuntu_virtual_machine" {
  name                  = "ubuntu_virtual_machine"
  location              = azurerm_resource_group.azure_resource_group.location
  resource_group_name   = azurerm_resource_group.azure_resource_group.name
  network_interface_ids = [azurerm_network_interface.ubuntu_dmz_network_interface.id]
  size                  = "Standard_DS1_v2"

  admin_ssh_key {
    username   = random_pet.admin_username.id
    public_key = tls_private_key.ssh_key.public_key_openssh
    #public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    name                 = "ubuntuOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name  = "ubuntu"
  admin_username = random_pet.admin_username.id

}
