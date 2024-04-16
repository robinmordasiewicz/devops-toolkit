# Changing PIP/UDR

## Diagram

![Changing PIP/UDR](https://learn.microsoft.com/en-us/azure/architecture/networking/guide/images/nvaha-pipudr-internet.png)

## Sizing

https://learn.microsoft.com/en-us/azure/virtual-machines/fsv2-series

<!-- BEGIN_TF_DOCS -->
## terraform.auto.tfvars

```hcl
location                             = "canadacentral"
resource_group                       = "my-resource-group"
owner_email                          = "root@example.com"
hub-virtual-network_address_prefix   = "10.0.0.0/16"
hub-external-subnet_name             = "hub-external_subnet"
hub-external-subnet_prefix           = "10.0.1.0/24"
hub-internal-subnet_name             = "hub-internal_subnet"
hub-internal-subnet_prefix           = "10.0.2.0/24"
spoke-virtual-network_address_prefix = "10.1.0.0/16"
spoke-subnet_name                    = "spoke_subnet"
spoke-subnet_prefix                  = "10.1.0.0/24"
```


## Requirements

| Name | Version |
|------|---------|
| terraform | 1.8.0 |
| azurerm | 3.99.0 |
| http | 3.4.1 |
| random | 3.6.1 |
| tls | 4.0.5 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| hub-external-subnet\_name | External Subnet Name. | `string` | n/a | yes |
| hub-external-subnet\_prefix | External Subnet Prefix. | `string` | n/a | yes |
| hub-internal-subnet\_name | Hub Subnet Name. | `string` | n/a | yes |
| hub-internal-subnet\_prefix | Hub Subnet Prefix. | `string` | n/a | yes |
| hub-virtual-network\_address\_prefix | Hub Virtual Network Address prefix. | `string` | n/a | yes |
| location | Azure region for resource group. | `string` | n/a | yes |
| owner\_email | Email address for use with Azure Owner tag. | `string` | n/a | yes |
| resource\_group | Azure resource group. | `string` | n/a | yes |
| spoke-subnet\_name | Spoke Subnet Name. | `string` | n/a | yes |
| spoke-subnet\_prefix | Spoke Subnet Prefix. | `string` | n/a | yes |
| spoke-virtual-network\_address\_prefix | Spoke Virtual Network Address prefix. | `string` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| admin\_password | Password for admin account |
| admin\_username | Username for admin account |
| hub-nva-management\_public\_ip | Management IP address |
| hub-nva-vip\_public\_ip | VIP IP address |
| management\_fqdn | Management FQDN |
| vip\_fqdn | VIP FQDN |
<!-- END_TF_DOCS -->
