resource "azurerm_linux_virtual_machine" "hub-nva_virtual_machine" {
  #checkov:skip=CKV_AZURE_178: Allow Fortigate to present HTTPS login UI instead of SSH
  #checkov:skip=CKV_AZURE_149: Allow Fortigate to present HTTPS login UI instead of SSH
  #checkov:skip=CKV_AZURE_1: Allow Fortigate to present HTTPS login UI instead of SSH
  depends_on                      = [null_resource.marketplace_agreement]
  name                            = "hub-nva_virtual_machine"
  computer_name                   = "hub-nva"
  availability_set_id             = azurerm_availability_set.hub-nva_availability_set.id
  admin_username                  = random_pet.admin_username.id
  disable_password_authentication = false #tfsec:ignore:AVD-AZU-0039
  admin_password                  = random_password.admin_password.result
  location                        = azurerm_resource_group.azure_resource_group.location
  resource_group_name             = azurerm_resource_group.azure_resource_group.name
  network_interface_ids           = [azurerm_network_interface.hub-nva-external_network_interface.id, azurerm_network_interface.hub-nva-internal_network_interface.id]
  size                            = local.vm-image[var.hub-nva-image].size
  allow_extension_operations      = false

  identity {
    type = "SystemAssigned"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    #disk_size_gb         = 256
  }
  plan {
    name      = local.vm-image[var.hub-nva-image].sku
    product   = local.vm-image[var.hub-nva-image].offer
    publisher = local.vm-image[var.hub-nva-image].publisher
  }
  source_image_reference {
    offer     = local.vm-image[var.hub-nva-image].offer
    publisher = local.vm-image[var.hub-nva-image].publisher
    sku       = local.vm-image[var.hub-nva-image].sku
    version   = "latest"
  }
  custom_data = base64encode(
    templatefile("cloud-init/${var.hub-nva-image}.conf",
      {
        VAR-hub-external-subnet-gateway              = var.hub-external-subnet-gateway
        VAR-spoke-check-internet-up-ip               = var.spoke-check-internet-up-ip
        VAR-spoke-default-gateway                    = cidrhost(var.hub-internal-subnet_prefix, 1)
        VAR-spoke-virtual-network_address_prefix     = var.spoke-virtual-network_address_prefix
        VAR-spoke-virtual-network_subnet             = cidrhost(var.spoke-virtual-network_address_prefix, 0)
        VAR-spoke-virtual-network_netmask            = cidrnetmask(var.spoke-virtual-network_address_prefix)
        VAR-spoke-container-server-ip                = var.spoke-container-server-ip
        VAR-hub-nva-vip                              = var.hub-nva-vip
        VAR-admin-username                           = random_pet.admin_username.id
        VAR-CERTIFICATE                              = tls_self_signed_cert.self_signed_cert.cert_pem
        VAR-PRIVATEKEY                               = tls_private_key.private_key.private_key_pem
        VAR-fwb_license_file                         = ""
        VAR-fwb_license_fortiflex                    = ""
        VAR-spoke-container-server-ollama-port       = var.spoke-container-server-ollama-port
        VAR-spoke-container-server-ollama-webui-port = var.spoke-container-server-ollama-webui-port
      }
    )
  )
}
