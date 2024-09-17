resource "azurerm_network_interface" "hub-nva-external_network_interface" {
  name                           = "hub-nva-external_network_interface"
  location                       = azurerm_resource_group.azure_resource_group.location
  resource_group_name            = azurerm_resource_group.azure_resource_group.name
  accelerated_networking_enabled = true
  ip_configuration {
    name                          = "hub-nva-external-management_ip_configuration"
    primary                       = true
    private_ip_address_allocation = "Static"
    private_ip_address            = var.hub-nva-management-ip
    subnet_id                     = azurerm_subnet.hub-external_subnet.id
    public_ip_address_id          = azurerm_public_ip.hub-nva-management_public_ip.id #checkov:skip=CKV_AZURE_119:Fortigate gets a public IP
  }
  ip_configuration {
    name                          = "hub-nva-external-vip_configuration"
    private_ip_address_allocation = "Static"
    private_ip_address            = var.hub-nva-vip
    subnet_id                     = azurerm_subnet.hub-external_subnet.id
    public_ip_address_id          = azurerm_public_ip.hub-nva-vip_public_ip.id #checkov:skip=CKV_AZURE_119:Fortigate gets a public IP
  }
}

resource "azurerm_network_interface" "hub-nva-internal_network_interface" {
  name                           = "hub-nva-internal_network_interface"
  location                       = azurerm_resource_group.azure_resource_group.location
  resource_group_name            = azurerm_resource_group.azure_resource_group.name
  accelerated_networking_enabled = true
  ip_forwarding_enabled          = true #checkov:skip=CKV_AZURE_118:Fortigate NIC needs IP forwarding.
  ip_configuration {
    name                          = "hub-nva-internal_ip_configuration"
    private_ip_address_allocation = "Static"
    private_ip_address            = var.hub-nva-gateway
    subnet_id                     = azurerm_subnet.hub-internal_subnet.id
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
        VAR-hub-external-subnet-gateway          = var.hub-external-subnet-gateway
        VAR-spoke-check-internet-up-ip           = var.spoke-check-internet-up-ip
        VAR-spoke-default-gateway                = cidrhost(var.hub-internal-subnet_prefix, 1)
        VAR-spoke-virtual-network_address_prefix = var.spoke-virtual-network_address_prefix
        VAR-spoke-virtual-network_subnet         = cidrhost(var.spoke-virtual-network_address_prefix, 0)
        VAR-spoke-virtual-network_netmask        = cidrnetmask(var.spoke-virtual-network_address_prefix)
        VAR-spoke-aks-node-ip                    = var.spoke-aks-node-ip
        VAR-hub-nva-vip                          = var.hub-nva-vip
        VAR-admin-username                       = random_pet.admin_username.id
        VAR-CERTIFICATE                          = tls_self_signed_cert.self_signed_cert.cert_pem
        VAR-PRIVATEKEY                           = tls_private_key.private_key.private_key_pem
        VAR-fwb_license_file                     = ""
        VAR-fwb_license_fortiflex                = ""
        VAR-spoke-aks-node-ollama-port           = var.spoke-aks-node-ollama-port
        VAR-spoke-aks-node-ollama-webui-port     = var.spoke-aks-node-ollama-webui-port
        VAR-spoke-aks-network                    = var.spoke-aks-subnet_prefix
      }
    )
  )
}

resource "azurerm_managed_disk" "log_disk" {
  name                 = "hub-nva-logs"
  location             = azurerm_resource_group.azure_resource_group.location
  resource_group_name  = azurerm_resource_group.azure_resource_group.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 30
}

resource "azurerm_virtual_machine_data_disk_attachment" "log_disk" {
  managed_disk_id    = azurerm_managed_disk.log_disk.id
  virtual_machine_id = azurerm_linux_virtual_machine.hub-nva_virtual_machine.id
  lun                = "0"
  caching            = "ReadWrite"
}
