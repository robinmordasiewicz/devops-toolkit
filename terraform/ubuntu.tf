resource "azurerm_network_interface" "ubuntu_spoke_network_interface" {
  name                = "ubuntu_spoke_network_interface"
  location            = azurerm_resource_group.azure_resource_group.location
  resource_group_name = azurerm_resource_group.azure_resource_group.name

  ip_configuration {
    name                          = "ubuntu-spoke_ipconfig"
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.spoke-subnet_prefix, 5)
    subnet_id                     = azurerm_subnet.spoke_subnet.id
  }
}

resource "azurerm_linux_virtual_machine" "ubuntu_virtual_machine" {
  name                  = "ubuntu_virtual_machine"
  location              = azurerm_resource_group.azure_resource_group.location
  resource_group_name   = azurerm_resource_group.azure_resource_group.name
  network_interface_ids = [azurerm_network_interface.ubuntu_spoke_network_interface.id]
  size                  = "Standard_DS1_v2"
  #allow_extension_operations = false

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

  computer_name  = "ubuntu"
  admin_username = random_pet.admin_username.id

  disable_password_authentication = false #tfsec:ignore:AVD-AZU-0039
  admin_password                  = random_password.admin_password.result
  custom_data                     = filebase64("cloud-init/ubuntu.yaml")

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.my_storage_account.primary_blob_endpoint
  }

}
