#resource "azurerm_marketplace_agreement" "fortigate" {
#  publisher = "fortinet"
#  offer     = "fortinet_fortigate-vm_v5"
#  plan      = "fortinet_fg-vm_payg_2022"
#}

#data "azurerm_marketplace_agreement" "fortigate" {
#  publisher = "fortigate"
#  offer     = "fortinet_fortigate-vm_v5"
#  plan      = "fortinet_fg-vm_payg_2022"
#}

#output "azurerm_marketplace_agreement_id" {
#  value = data.azurerm_marketplace_agreement.fortigate.id
#}

resource "azurerm_linux_virtual_machine" "hub-nva_virtual_machine" {
  #checkov:skip=CKV_AZURE_178: Allow Fortigate to present HTTPS login UI instead of SSH
  #checkov:skip=CKV_AZURE_149: Allow Fortigate to present HTTPS login UI instead of SSH
  #checkov:skip=CKV_AZURE_1: Allow Fortigate to present HTTPS login UI instead of SSH
  #  depends_on                      = [azurerm_marketplace_agreement.fortigate]
  name                            = "hub-nva_virtual_machine"
  computer_name                   = "hub-nva"
  availability_set_id             = azurerm_availability_set.hub-nva_availability_set.id
  admin_username                  = random_pet.admin_username.id
  disable_password_authentication = false #tfsec:ignore:AVD-AZU-0039
  admin_password                  = random_password.admin_password.result
  location                        = azurerm_resource_group.azure_resource_group.location
  resource_group_name             = azurerm_resource_group.azure_resource_group.name
  network_interface_ids           = [azurerm_network_interface.hub-nva-external_network_interface.id, azurerm_network_interface.hub-nva-internal_network_interface.id]
  size                            = "Standard_F8s_v2"
  allow_extension_operations      = false

  identity {
    type = "SystemAssigned"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  plan {
    name      = "fortinet_fg-vm_payg_2022"
    product   = "fortinet_fortigate-vm_v5"
    publisher = "fortinet"
  }
  source_image_reference {
    offer     = "fortinet_fortigate-vm_v5"
    publisher = "fortinet"
    sku       = "fortinet_fg-vm_payg_2022"
    version   = "latest"
  }
  custom_data = filebase64("cloud-init/fortigate.conf")
}
