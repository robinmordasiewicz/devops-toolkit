location                           = "canadacentral"
owner_email                        = "root@example.com"
hub-virtual-network_address_prefix = "10.0.0.0/24"
hub-external-subnet_name           = "hub-external_subnet"
hub-external-subnet_prefix         = "10.0.0.0/27"
hub-internal-subnet_name           = "hub-internal_subnet"
hub-internal-subnet_prefix         = "10.0.0.32/27"
hub-nva-publisher                  = "fortinet"
#hub-nva-offer                        = "fortinet_fortigate-vm_v5"
hub-nva-offer                        = "fortinet_fortiweb-vm_v5"
hub-nva-sku                          = "fortinet_fw-vm_payg_v3"
hub-nva-size                         = "Standard_F8s_v2"
hub-nva-management-action            = "Allow" # Can be either Allow or Deny
hub-nva-management-port              = "443"
hub-nva-management-ip                = "10.0.0.4"
hub-nva-vip                          = "10.0.0.5"
hub-nva-gateway                      = "10.0.0.37"
spoke-virtual-network_address_prefix = "10.1.1.0/24"
spoke-subnet_name                    = "spoke_subnet"
spoke-subnet_prefix                  = "10.1.1.0/24"
spoke-container-server-publisher     = "Canonical"
spoke-container-server-offer         = "0001-com-ubuntu-server-jammy"
spoke-container-server-sku           = "22_04-lts-gen2"
spoke-container-server-size          = "Standard_DS1_v2"
spoke-container-server-ip            = "10.1.1.5"
spoke-check-internet-up-ip           = "8.8.8.8"
