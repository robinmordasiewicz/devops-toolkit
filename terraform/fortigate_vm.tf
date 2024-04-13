resource "random_pet" "admin_username" {
  keepers = {
    resource_group_name = azurerm_resource_group.azure_resource_group.name
  }
}

resource "random_password" "admin_password" {
  keepers = {
    resource_group_name = azurerm_resource_group.azure_resource_group.name
  }
  length      = 20
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
  special     = true
}
resource "azurerm_network_interface" "fortigate_external_network_interface" {
  name                          = "fortigate_external_network_interface"
  location                      = azurerm_resource_group.azure_resource_group.location
  resource_group_name           = azurerm_resource_group.azure_resource_group.name
  enable_accelerated_networking = true
  ip_configuration {
    name                          = "fortigate-external-ipconfig"
    primary                       = true
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.external_prefix, 4)
    subnet_id                     = azurerm_subnet.external_subnet.id
    #checkov:skip=CKV_AZURE_119:Fortigate gets a public IP
    public_ip_address_id = azurerm_public_ip.mgmt_public_ip.id
  }
  ip_configuration {
    name                          = "VIP-external-ipconfig"
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.external_prefix, 100)
    subnet_id                     = azurerm_subnet.external_subnet.id
    #checkov:skip=CKV_AZURE_119:Fortigate gets a public IP
    public_ip_address_id = azurerm_public_ip.vip_public_ip.id
  }
}

resource "azurerm_network_interface" "fortigate_internal_network_interface" {
  name                          = "fortigate_internal_network_interface"
  location                      = azurerm_resource_group.azure_resource_group.location
  resource_group_name           = azurerm_resource_group.azure_resource_group.name
  enable_accelerated_networking = true
  #checkov:skip=CKV_AZURE_118:Fortigate internal NIC needs to IP forwarding.
  enable_ip_forwarding = true
  ip_configuration {
    name                          = "fortigate-internal-ipconfig"
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.internal_prefix, 4)
    subnet_id                     = azurerm_subnet.internal_subnet.id
  }
}

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

resource "azurerm_linux_virtual_machine" "fortigate_virtual_machine" {
  #  depends_on                      = [azurerm_marketplace_agreement.fortigate]
  name                = "fortigate_virtual_machine"
  computer_name       = "fortigate"
  admin_username      = random_pet.admin_username.id
  availability_set_id = azurerm_availability_set.fortinet_availability_set.id
  #tfsec:ignore:AVD-AZU-0039
  disable_password_authentication = false
  location                        = azurerm_resource_group.azure_resource_group.location
  resource_group_name             = azurerm_resource_group.azure_resource_group.name
  network_interface_ids           = [azurerm_network_interface.fortigate_external_network_interface.id, azurerm_network_interface.fortigate_internal_network_interface.id]
  size                            = "Standard_F8s_v2"
  #checkov:skip=CKV_AZURE_149:Enable password authentiction for testing
  #checkov:skip=CKV_AZURE_1:Enable password authentiction for testing
  admin_password             = random_password.admin_password.result
  allow_extension_operations = false
  admin_ssh_key {
    username   = random_pet.admin_username.id
    public_key = tls_private_key.ssh_key.public_key_openssh
  }
  #boot_diagnostics {
  #  storage_account_uri = azurerm_storage_account.azure_storage_account.primary_blob_endpoint
  #}
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

output "admin_username" {
  description = "Username for admin account"
  value       = random_pet.admin_username.id
}

output "admin_password" {
  description = "Password for admin account"
  value       = random_password.admin_password.result
  sensitive   = true
}
