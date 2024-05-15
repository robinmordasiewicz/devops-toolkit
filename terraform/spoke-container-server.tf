resource "azurerm_linux_virtual_machine" "spoke-container-server_virtual_machine" {
  #checkov:skip=CKV_AZURE_178: SSH is disabled
  #checkov:skip=CKV_AZURE_149: SSH is disabled
  #checkov:skip=CKV_AZURE_1: SSH is disabled
  name                            = "spoke-container-server_virtual_machine"
  computer_name                   = "container-server"
  admin_username                  = random_pet.admin_username.id
  disable_password_authentication = false #tfsec:ignore:AVD-AZU-0039
  admin_password                  = random_password.admin_password.result
  location                        = azurerm_resource_group.azure_resource_group.location
  zone                            = local.vm-image[var.spoke-container-server-image].zone
  resource_group_name             = azurerm_resource_group.azure_resource_group.name
  network_interface_ids           = [azurerm_network_interface.spoke-container-server_network_interface.id]
  secure_boot_enabled             = false
  size = var.spoke-container-server-image-gpu == true ? local.vm-image[var.spoke-container-server-image].size_gpu : local.vm-image[var.spoke-container-server-image].size
  allow_extension_operations      = false
  provision_vm_agent              = true
  vtpm_enabled                    = true
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb = var.spoke-container-server-image-gpu == true ? "1024" : "30"
  }
  dynamic "plan" {
    for_each = local.vm-image[var.spoke-container-server-image].terms == true ? [1] : []
    content {
      name      = local.vm-image[var.spoke-container-server-image].sku
      product   = local.vm-image[var.spoke-container-server-image].offer
      publisher = local.vm-image[var.spoke-container-server-image].publisher
    }
  }
  source_image_reference {
    offer     = local.vm-image[var.spoke-container-server-image].offer
    publisher = local.vm-image[var.spoke-container-server-image].publisher
    sku       = local.vm-image[var.spoke-container-server-image].sku
    version   = "latest"
  }
  custom_data = base64encode(
    templatefile("cloud-init/${var.spoke-container-server-image}.conf",
      {
        VAR-spoke-check-internet-up-ip = var.spoke-check-internet-up-ip
        VAR-spoke-container-server-image-gpu = var.spoke-container-server-image-gpu
        VAR-spoke-container-server-ollama-port = var.spoke-container-server-ollama-port
        VAR-spoke-container-server-ollama-webui-port = var.spoke-container-server-ollama-webui-port
      }
    )
  )
}
