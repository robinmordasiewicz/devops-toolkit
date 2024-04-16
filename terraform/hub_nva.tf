resource "null_resource" "marketplace_agreement" {
  provisioner "local-exec" {
    command = "az vm image terms accept --publisher ${var.hub-nva-publisher} --offer ${var.hub-nva-offer} --plan ${var.hub-nva-sku}"
  }
}

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
  size                            = var.hub-nva-size
  allow_extension_operations      = false

  identity {
    type = "SystemAssigned"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  plan {
    name      = var.hub-nva-sku
    product   = var.hub-nva-offer
    publisher = var.hub-nva-publisher
  }
  source_image_reference {
    offer     = var.hub-nva-offer
    publisher = var.hub-nva-publisher
    sku       = var.hub-nva-sku
    version   = "latest"
  }
  custom_data = filebase64("cloud-init/hub-nva.conf")
}
