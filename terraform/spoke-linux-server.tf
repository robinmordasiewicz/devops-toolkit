resource "azurerm_network_interface" "spoke-linux-server_network_interface" {
  name                           = "spoke-linux-server_network_interface"
  location                       = azurerm_resource_group.azure_resource_group.location
  resource_group_name            = azurerm_resource_group.azure_resource_group.name
  accelerated_networking_enabled = true
  ip_configuration {
    name                          = "spoke-linux-server_ip_configuration"
    private_ip_address_allocation = "Static"
    private_ip_address            = var.spoke-linux-server-ip
    subnet_id                     = azurerm_subnet.spoke_subnet.id
  }
}

resource "azurerm_linux_virtual_machine" "spoke-linux-server_virtual_machine" {
  #checkov:skip=CKV_AZURE_178: SSH is disabled
  #checkov:skip=CKV_AZURE_149: SSH is disabled
  #checkov:skip=CKV_AZURE_1: SSH is disabled
  name                            = "spoke-linux-server_virtual_machine"
  computer_name                   = "linux-server"
  admin_username                  = random_pet.admin_username.id
  disable_password_authentication = false #tfsec:ignore:AVD-AZU-0039
  admin_password                  = random_password.admin_password.result
  location                        = azurerm_resource_group.azure_resource_group.location
  zone                            = local.vm-image[var.spoke-linux-server-image].zone
  resource_group_name             = azurerm_resource_group.azure_resource_group.name
  network_interface_ids           = [azurerm_network_interface.spoke-linux-server_network_interface.id]
  secure_boot_enabled             = false
  size                            = var.spoke-linux-server-image-gpu == true ? local.vm-image[var.spoke-linux-server-image].size_gpu : local.vm-image[var.spoke-linux-server-image].size
  allow_extension_operations      = false
  provision_vm_agent              = true
  vtpm_enabled                    = true
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = var.spoke-linux-server-image-gpu == true ? "1024" : "30"
  }
  dynamic "plan" {
    for_each = local.vm-image[var.spoke-linux-server-image].terms == true ? [1] : []
    content {
      name      = local.vm-image[var.spoke-linux-server-image].sku
      product   = local.vm-image[var.spoke-linux-server-image].offer
      publisher = local.vm-image[var.spoke-linux-server-image].publisher
    }
  }
  source_image_reference {
    offer     = local.vm-image[var.spoke-linux-server-image].offer
    publisher = local.vm-image[var.spoke-linux-server-image].publisher
    sku       = local.vm-image[var.spoke-linux-server-image].sku
    version   = "latest"
  }
  custom_data = base64encode(
    templatefile("cloud-init/${var.spoke-linux-server-image}.conf",
      {
        VAR-spoke-check-internet-up-ip           = var.spoke-check-internet-up-ip
        VAR-spoke-linux-server-image-gpu         = var.spoke-linux-server-image-gpu
        VAR-spoke-linux-server-ollama-port       = var.spoke-linux-server-ollama-port
        VAR-spoke-linux-server-ollama-webui-port = var.spoke-linux-server-ollama-webui-port
      }
    )
  )
}
