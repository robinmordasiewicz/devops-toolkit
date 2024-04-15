resource "azurerm_linux_virtual_machine" "spoke-container-server_virtual_machine" {
  name                            = "spoke-container-server_virtual_machine"
  computer_name                   = "container-server"
  admin_username                  = random_pet.admin_username.id
  disable_password_authentication = true
  location                        = azurerm_resource_group.azure_resource_group.location
  resource_group_name             = azurerm_resource_group.azure_resource_group.name
  network_interface_ids           = [azurerm_network_interface.spoke-container-server_network_interface.id]
  size                            = "Standard_DS1_v2"
  allow_extension_operations      = false

  admin_ssh_key {
    username   = random_pet.admin_username.id
    public_key = tls_private_key.ssh_key.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  custom_data = filebase64("cloud-init/container-server.yaml")

}
