# Changing PIP/UDR

https://learn.microsoft.com/en-us/azure/architecture/networking/guide/nva-ha#pip-udr-nvas-without-snat

## Diagram

![Changing PIP/UDR](https://learn.microsoft.com/en-us/azure/architecture/networking/guide/images/nvaha-pipudr-internet.png)

## Sizing

https://learn.microsoft.com/en-us/azure/virtual-machines/fsv2-series

## Marketplace SKUs

az vm image list --publisher fortinet --all

az account list-locations --query "[].name" --output json

<!-- BEGIN_TF_DOCS -->
## terraform.auto.tfvars

```hcl
location                             = "eastus"
owner_email                          = "root@example.com"
hub-nva-image                        = "fortigate"
hub-virtual-network_address_prefix   = "10.0.0.0/24"
hub-external-subnet_name             = "hub-external_subnet"
hub-external-subnet_prefix           = "10.0.0.0/27"
hub-external-subnet-gateway          = "10.0.0.1"
hub-internal-subnet_name             = "hub-internal_subnet"
hub-internal-subnet_prefix           = "10.0.0.32/27"
hub-nva-management-action            = "Allow"
hub-nva-management-ip                = "10.0.0.4"
hub-nva-vip                          = "10.0.0.5"
hub-nva-gateway                      = "10.0.0.37"
spoke-container-server-image-gpu     = true
spoke-virtual-network_address_prefix = "10.1.1.0/24"
spoke-subnet_name                    = "spoke_subnet"
spoke-subnet_prefix                  = "10.1.1.0/24"
spoke-container-server-ip            = "10.1.1.5"
spoke-check-internet-up-ip           = "8.8.8.8"
```


## Requirements

| Name | Version |
|------|---------|
| terraform | >=1.6 |
| azurerm | 3.103.1 |
| http | 3.4.1 |
| null | 3.2.2 |
| random | 3.6.1 |
| tls | 4.0.5 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| hub-external-subnet-gateway | Azure gateway IP address to the Internet | `string` | `"10.0.0.1"` | no |
| hub-external-subnet\_name | External Subnet Name. | `string` | `"hub-external_subnet"` | no |
| hub-external-subnet\_prefix | External Subnet Prefix. | `string` | `"10.0.0.0/27"` | no |
| hub-internal-subnet\_name | Hub Subnet Name. | `string` | `"hub-internal_subnet"` | no |
| hub-internal-subnet\_prefix | Hub Subnet Prefix. | `string` | `"10.0.0.32/27"` | no |
| hub-nva-gateway | Hub NVA Gateway IP Address | `string` | `"10.0.0.37"` | no |
| hub-nva-image | NVA image product | `string` | `"fortigate"` | no |
| hub-nva-management-action | Allow or Deny access to Management | `string` | `"Deny"` | no |
| hub-nva-management-ip | Hub NVA Management IP Address | `string` | `"10.0.0.4"` | no |
| hub-nva-vip | Hub NVA Gateway Virtual IP Address | `string` | `"10.0.0.5"` | no |
| hub-virtual-network\_address\_prefix | Hub Virtual Network Address prefix. | `string` | `"10.0.0.0/24"` | no |
| location | Azure region for resource group. | `string` | `"canadacentral"` | no |
| owner\_email | Email address for use with Azure Owner tag. | `string` | `"root@example.com"` | no |
| spoke-check-internet-up-ip | Spoke Container Server Checks the Internet at this IP Address | `string` | `"8.8.8.8"` | no |
| spoke-container-server-image | Container server image product | `string` | `"ubuntu"` | no |
| spoke-container-server-image-gpu | Set to true to enable GPU workloads | `bool` | `false` | no |
| spoke-container-server-ip | Spoke Container Server IP Address | `string` | `"10.1.1.5"` | no |
| spoke-container-server-ollama-port | Port for ollama | `string` | `"11434"` | no |
| spoke-container-server-ollama-webui-port | Port for the ollama web ui | `string` | `"8080"` | no |
| spoke-subnet\_name | Spoke Subnet Name. | `string` | `"spoke_subnet"` | no |
| spoke-subnet\_prefix | Spoke Subnet Prefix. | `string` | `"10.1.1.0/24"` | no |
| spoke-virtual-network\_address\_prefix | Spoke Virtual Network Address prefix. | `string` | `"10.1.1.0/24"` | no |
## Outputs

| Name | Description |
|------|-------------|
| admin\_password | Password for admin account |
| admin\_username | Username for admin account |
| management\_fqdn | Management FQDN |
| vip\_fqdn | VIP FQDN |
<!-- END_TF_DOCS -->
