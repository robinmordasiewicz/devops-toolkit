# Terraform Docs

## Sizing

https://learn.microsoft.com/en-us/azure/virtual-machines/fsv2-series

## Diagram

```mermaid
%%tfmermaid
%%{init:{"theme":"default","themeVariables":{"lineColor":"#6f7682","textColor":"#6f7682"}}}%%
flowchart LR
classDef r fill:#5c4ee5,stroke:#444,color:#fff
classDef v fill:#eeedfc,stroke:#eeedfc,color:#5c4ee5
classDef ms fill:none,stroke:#dce0e6,stroke-width:2px
classDef vs fill:none,stroke:#dce0e6,stroke-width:4px,stroke-dasharray:10
classDef ps fill:none,stroke:none
classDef cs fill:#f7f8fa,stroke:#dce0e6,stroke-width:2px
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.8.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.99.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | 3.4.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.99.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_availability_set.hub-nva_availability_set](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/availability_set) | resource |
| [azurerm_linux_virtual_machine.hub-nva_virtual_machine](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/linux_virtual_machine) | resource |
| [azurerm_linux_virtual_machine.spoke-container-server_virtual_machine](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.hub-nva-external_network_interface](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/network_interface) | resource |
| [azurerm_network_interface.hub-nva-internal_network_interface](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/network_interface) | resource |
| [azurerm_network_interface.spoke-container-server_network_interface](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/network_interface) | resource |
| [azurerm_network_security_group.hub-external_network_security_group](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.hub-internal_network_security_group](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.spoke_network_security_group](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.hub-nva-management_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/public_ip) | resource |
| [azurerm_public_ip.hub-nva-vip_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/public_ip) | resource |
| [azurerm_resource_group.azure_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/resource_group) | resource |
| [azurerm_route_table.hub_route_table](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/route_table) | resource |
| [azurerm_route_table.spoke_route_table](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/route_table) | resource |
| [azurerm_subnet.hub-external_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/subnet) | resource |
| [azurerm_subnet.hub-internal_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/subnet) | resource |
| [azurerm_subnet.spoke_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.hub-external-subnet-network-security-group_association](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.hub-internal-subnet-network-security-group_association](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.spokesubnet-network-security-group__association](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.hub-external-route-table_association](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/subnet_route_table_association) | resource |
| [azurerm_subnet_route_table_association.hub-internal-routing-table_association](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/subnet_route_table_association) | resource |
| [azurerm_subnet_route_table_association.spoke-route-table_association](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/subnet_route_table_association) | resource |
| [azurerm_virtual_network.hub_virtual_network](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network.spoke_virtual_network](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_peering.hub-to-spoke_virtual_network_peering](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.spoke-to-hub_virtual_network_peering](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/resources/virtual_network_peering) | resource |
| [random_integer.random_number](https://registry.terraform.io/providers/hashicorp/random/3.6.0/docs/resources/integer) | resource |
| [random_password.admin_password](https://registry.terraform.io/providers/hashicorp/random/3.6.0/docs/resources/password) | resource |
| [random_pet.admin_username](https://registry.terraform.io/providers/hashicorp/random/3.6.0/docs/resources/pet) | resource |
| [tls_private_key.ssh_key](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/private_key) | resource |
| [azurerm_public_ip.hub-nva-management_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/data-sources/public_ip) | data source |
| [azurerm_public_ip.hub-nva-vip_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/3.99.0/docs/data-sources/public_ip) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hub-external-subnet_name"></a> [hub-external-subnet\_name](#input\_hub-external-subnet\_name) | External Subnet Name. | `string` | n/a | yes |
| <a name="input_hub-external-subnet_prefix"></a> [hub-external-subnet\_prefix](#input\_hub-external-subnet\_prefix) | External Subnet Prefix. | `string` | n/a | yes |
| <a name="input_hub-internal-subnet_name"></a> [hub-internal-subnet\_name](#input\_hub-internal-subnet\_name) | Hub Subnet Name. | `string` | n/a | yes |
| <a name="input_hub-internal-subnet_prefix"></a> [hub-internal-subnet\_prefix](#input\_hub-internal-subnet\_prefix) | Hub Subnet Prefix. | `string` | n/a | yes |
| <a name="input_hub-virtual-network_address_prefix"></a> [hub-virtual-network\_address\_prefix](#input\_hub-virtual-network\_address\_prefix) | Hub Virtual Network Address prefix. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure region for resource group. | `string` | n/a | yes |
| <a name="input_owner_email"></a> [owner\_email](#input\_owner\_email) | Email address for use with Azure Owner tag. | `string` | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Azure resource group. | `string` | n/a | yes |
| <a name="input_spoke-subnet_name"></a> [spoke-subnet\_name](#input\_spoke-subnet\_name) | Spoke Subnet Name. | `string` | n/a | yes |
| <a name="input_spoke-subnet_prefix"></a> [spoke-subnet\_prefix](#input\_spoke-subnet\_prefix) | Spoke Subnet Prefix. | `string` | n/a | yes |
| <a name="input_spoke-virtual-network_address_prefix"></a> [spoke-virtual-network\_address\_prefix](#input\_spoke-virtual-network\_address\_prefix) | Spoke Virtual Network Address prefix. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | Password for admin account |
| <a name="output_admin_username"></a> [admin\_username](#output\_admin\_username) | Username for admin account |
| <a name="output_hub-nva-management_public_ip"></a> [hub-nva-management\_public\_ip](#output\_hub-nva-management\_public\_ip) | Management IP address |
| <a name="output_hub-nva-vip_public_ip"></a> [hub-nva-vip\_public\_ip](#output\_hub-nva-vip\_public\_ip) | VIP IP address |
| <a name="output_management_fqdn"></a> [management\_fqdn](#output\_management\_fqdn) | Management FQDN |
| <a name="output_tls_private_key"></a> [tls\_private\_key](#output\_tls\_private\_key) | TSL private key |
| <a name="output_vip_fqdn"></a> [vip\_fqdn](#output\_vip\_fqdn) | VIP FQDN |
<!-- END_TF_DOCS -->
