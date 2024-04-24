locals {
  vm-image = {
    "ubuntu" = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      size      = "Standard_F2s_v2"
      sku       = "22_04-lts-gen2"
      version   = "latest"
      terms     = false
    },
    "almalinux" = {
      publisher = "almalinux"
      offer     = "almalinux"
      size      = "Standard_F2s_v2"
      version   = "latest"
      sku       = "8-gen2"
      terms     = true
    },
    "fortigate" = {
      publisher       = "fortinet"
      offer           = "fortinet_fortigate-vm_v5"
      size            = "Standard_F8s_v2"
      version         = "latest"
      sku             = "fortinet_fg-vm_payg_2022"
      management-port = "443"
      version         = "latest"
      terms           = true
    },
    "fortiweb" = {
      publisher       = "fortinet"
      offer           = "fortinet_fortiweb-vm_v5"
      size            = "Standard_F8s_v2"
      version         = "latest"
      sku             = "fortinet_fw-vm_payg_v3"
      management-port = "8443"
      version         = "latest"
      terms           = true
    },
    "fortiadc" = {
      publisher       = "fortinet"
      offer           = "fortinet-fortiadc"
      size            = "Standard_D4s_v3"
      version         = "latest"
      sku             = "fortinet-fad-vm_payg-10gbps"
      management-port = "443"
      version         = "latest"
      terms           = true
    }
  }
}
