# Changing PIP/UDR

https://learn.microsoft.com/en-us/azure/architecture/networking/guide/nva-ha#pip-udr-nvas-without-snat

## Diagram

![Changing PIP/UDR](https://learn.microsoft.com/en-us/azure/architecture/networking/guide/images/nvaha-pipudr-internet.png)

## Sizing

https://learn.microsoft.com/en-us/azure/virtual-machines/fsv2-series

## Marketplace SKUs

az vm image list --publisher fortinet --all

<!-- BEGIN_TF_DOCS -->
## terraform.auto.tfvars

```hcl
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
hub-nva-management-port              = "8443"
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
```


## Requirements

| Name | Version |
|------|---------|
| terraform | >=1.6 |
| azurerm | 3.99.0 |
| http | 3.4.1 |
| null | 3.2.2 |
| random | 3.6.1 |
| tls | 4.0.5 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| hub-external-subnet\_name | External Subnet Name. | `string` | n/a | yes |
| hub-external-subnet\_prefix | External Subnet Prefix. | `string` | n/a | yes |
| hub-internal-subnet\_name | Hub Subnet Name. | `string` | n/a | yes |
| hub-internal-subnet\_prefix | Hub Subnet Prefix. | `string` | n/a | yes |
| hub-nva-gateway | Hub NVA Gateway IP Address | `string` | n/a | yes |
| hub-nva-management-action | Allow or Deny access to Management | `string` | n/a | yes |
| hub-nva-management-ip | Hub NVA Management IP Address | `string` | n/a | yes |
| hub-nva-management-port | Hub NVA Management TCP Port | `string` | n/a | yes |
| hub-nva-offer | Hub NVA Offer | `string` | n/a | yes |
| hub-nva-publisher | Hub NVA Publisher | `string` | n/a | yes |
| hub-nva-size | Hub NVA Size | `string` | n/a | yes |
| hub-nva-sku | Hub NVA SKU | `string` | n/a | yes |
| hub-nva-vip | Hub NVA Gateway Virtual IP Address | `string` | n/a | yes |
| hub-virtual-network\_address\_prefix | Hub Virtual Network Address prefix. | `string` | n/a | yes |
| location | Azure region for resource group. | `string` | n/a | yes |
| owner\_email | Email address for use with Azure Owner tag. | `string` | n/a | yes |
| spoke-check-internet-up-ip | Spoke Container Server Checks the Internet at this IP Address | `string` | n/a | yes |
| spoke-container-server-ip | Spoke Container Server IP Address | `string` | n/a | yes |
| spoke-container-server-offer | Spoke Container Server Offer | `string` | n/a | yes |
| spoke-container-server-publisher | Spoke Container Server Publisher | `string` | n/a | yes |
| spoke-container-server-size | Spoke Container Server Size | `string` | n/a | yes |
| spoke-container-server-sku | Spoke Container Server SKU | `string` | n/a | yes |
| spoke-subnet\_name | Spoke Subnet Name. | `string` | n/a | yes |
| spoke-subnet\_prefix | Spoke Subnet Prefix. | `string` | n/a | yes |
| spoke-virtual-network\_address\_prefix | Spoke Virtual Network Address prefix. | `string` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| admin\_password | Password for admin account |
| admin\_username | Username for admin account |
| cert\_pem | n/a |
| hub-nva-management\_public\_ip | Management IP address |
| hub-nva-vip\_public\_ip | VIP IP address |
| management\_fqdn | Management FQDN |
| private\_key\_pem | n/a |
| vip\_fqdn | VIP FQDN |
<!-- END_TF_DOCS -->
