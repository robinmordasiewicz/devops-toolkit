locals {
  vm-image = {
    "linux-server" = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      size      = "Standard_F16s_v2"
      #size_gpu     = "Standard_NC24ads_A100_v4"
      size_gpu     = "Standard_NC6s_v3"
      disk_size_gb = "1024"
      sku          = "22_04-lts-gen2"
      version      = "latest"
      zone         = "2"
      terms        = false
    },
    "fortigate" = {
      publisher       = "fortinet"
      offer           = "fortinet_fortigate-vm_v5"
      size            = "Standard_F16s_v2"
      version         = "latest"
      sku             = "fortinet_fg-vm_payg_2023"
      management-port = "443"
      terms           = true
    },
    "fortiweb" = {
      publisher       = "fortinet"
      offer           = "fortinet_fortiweb-vm_v5"
      size            = "Standard_F16s_v2"
      version         = "latest"
      sku             = "fortinet_fw-vm_payg_v3"
      management-port = "8443"
      terms           = true
    },
    "fortiadc" = {
      publisher       = "fortinet"
      offer           = "fortinet-fortiadc"
      size            = "Standard_F16s_v2"
      version         = "latest"
      sku             = "fortinet-fad-vm_payg-10gbps"
      management-port = "443"
      terms           = true
    },
    "aks" = {
      size      = "Standard_F16s_v2"
      version   = "latest"
      terms     = false
      offer     = ""
      sku       = ""
      publisher = ""
    }
  }
}
