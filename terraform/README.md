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
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.97.1 |
| <a name="requirement_http"></a> [http](#requirement\_http) | 3.4.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.97.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_availability_set.fortinet_availability_set](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/availability_set) | resource |
| [azurerm_container_group.container](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/container_group) | resource |
| [azurerm_linux_virtual_machine.fortigate_virtual_machine](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/linux_virtual_machine) | resource |
| [azurerm_linux_virtual_machine.ubuntu_virtual_machine](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.fortigate_external_network_interface](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/network_interface) | resource |
| [azurerm_network_interface.fortigate_internal_network_interface](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/network_interface) | resource |
| [azurerm_network_interface.ubuntu_spoke_network_interface](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/network_interface) | resource |
| [azurerm_network_security_group.external_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.internal_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.spoke_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.mgmt_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/public_ip) | resource |
| [azurerm_public_ip.vip_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/public_ip) | resource |
| [azurerm_resource_group.azure_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/resource_group) | resource |
| [azurerm_route_table.hub-route_table](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/route_table) | resource |
| [azurerm_route_table.spoke-route_table](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/route_table) | resource |
| [azurerm_storage_account.my_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/storage_account) | resource |
| [azurerm_subnet.external_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/subnet) | resource |
| [azurerm_subnet.internal_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/subnet) | resource |
| [azurerm_subnet.spoke_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.external_association](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.internal_association](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.spoke_association](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.hub-external-routing_table_association](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/subnet_route_table_association) | resource |
| [azurerm_subnet_route_table_association.hub-internal-routing_table_association](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/subnet_route_table_association) | resource |
| [azurerm_subnet_route_table_association.spoke-routing_table_association](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/subnet_route_table_association) | resource |
| [azurerm_virtual_network.hub-vnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network.spoke-vnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_peering.hub_peer](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.spoke_peer](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/virtual_network_peering) | resource |
| [random_id.random_id](https://registry.terraform.io/providers/hashicorp/random/3.6.0/docs/resources/id) | resource |
| [random_integer.random_number](https://registry.terraform.io/providers/hashicorp/random/3.6.0/docs/resources/integer) | resource |
| [random_password.admin_password](https://registry.terraform.io/providers/hashicorp/random/3.6.0/docs/resources/password) | resource |
| [random_pet.admin_username](https://registry.terraform.io/providers/hashicorp/random/3.6.0/docs/resources/pet) | resource |
| [random_string.container_name](https://registry.terraform.io/providers/hashicorp/random/3.6.0/docs/resources/string) | resource |
| [tls_private_key.ssh_key](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/private_key) | resource |
| [azurerm_public_ip.mgmt_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/data-sources/public_ip) | data source |
| [azurerm_public_ip.vip_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/data-sources/public_ip) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_group_name_prefix"></a> [container\_group\_name\_prefix](#input\_container\_group\_name\_prefix) | Prefix of the container group name that's combined with a random value so name is unique in your Azure subscription. | `string` | `"acigroup"` | no |
| <a name="input_container_name_prefix"></a> [container\_name\_prefix](#input\_container\_name\_prefix) | Prefix of the container name that's combined with a random value so name is unique in your Azure subscription. | `string` | `"aci"` | no |
| <a name="input_cpu_cores"></a> [cpu\_cores](#input\_cpu\_cores) | The number of CPU cores to allocate to the container. | `number` | `1` | no |
| <a name="input_external-subnet_name"></a> [external-subnet\_name](#input\_external-subnet\_name) | External Subnet Name. | `string` | n/a | yes |
| <a name="input_external-subnet_prefix"></a> [external-subnet\_prefix](#input\_external-subnet\_prefix) | External Subnet Prefix. | `string` | n/a | yes |
| <a name="input_hub-vnet_address_prefix"></a> [hub-vnet\_address\_prefix](#input\_hub-vnet\_address\_prefix) | Virtual Network Address prefix. | `string` | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | Container image to deploy. Should be of the form repoName/imagename:tag for images stored in public Docker Hub, or a fully qualified URI for other registries. Images from private registries require additional registry credentials. | `string` | `"docker.io/vulnerables/web-dvwa"` | no |
| <a name="input_internal-subnet_name"></a> [internal-subnet\_name](#input\_internal-subnet\_name) | Internal Subnet Name. | `string` | n/a | yes |
| <a name="input_internal-subnet_prefix"></a> [internal-subnet\_prefix](#input\_internal-subnet\_prefix) | Internal Subnet Prefix. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure region for resource group. | `string` | n/a | yes |
| <a name="input_memory_in_gb"></a> [memory\_in\_gb](#input\_memory\_in\_gb) | The amount of memory to allocate to the container in gigabytes. | `number` | `2` | no |
| <a name="input_owner_email"></a> [owner\_email](#input\_owner\_email) | Email address for use with Azure Owner tag. | `string` | n/a | yes |
| <a name="input_port"></a> [port](#input\_port) | Port to open on the container and the public IP address. | `number` | `80` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Azure resource group. | `string` | n/a | yes |
| <a name="input_restart_policy"></a> [restart\_policy](#input\_restart\_policy) | The behavior of Azure runtime if container has stopped. | `string` | `"Always"` | no |
| <a name="input_spoke-subnet_name"></a> [spoke-subnet\_name](#input\_spoke-subnet\_name) | Spoke Subnet Name. | `string` | n/a | yes |
| <a name="input_spoke-subnet_prefix"></a> [spoke-subnet\_prefix](#input\_spoke-subnet\_prefix) | Spoke Subnet Prefix. | `string` | n/a | yes |
| <a name="input_spoke-vnet_address_prefix"></a> [spoke-vnet\_address\_prefix](#input\_spoke-vnet\_address\_prefix) | Virtual Network Address prefix. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | Password for admin account |
| <a name="output_admin_username"></a> [admin\_username](#output\_admin\_username) | Username for admin account |
| <a name="output_container_ipv4_address"></a> [container\_ipv4\_address](#output\_container\_ipv4\_address) | n/a |
| <a name="output_mgmt_fqdn"></a> [mgmt\_fqdn](#output\_mgmt\_fqdn) | Management FQDN |
| <a name="output_mgmt_public_ip_address"></a> [mgmt\_public\_ip\_address](#output\_mgmt\_public\_ip\_address) | Management IP address |
| <a name="output_tls_private_key"></a> [tls\_private\_key](#output\_tls\_private\_key) | TSL private key |
| <a name="output_vip_fqdn"></a> [vip\_fqdn](#output\_vip\_fqdn) | VIP FQDN |
| <a name="output_vip_public_ip_address"></a> [vip\_public\_ip\_address](#output\_vip\_public\_ip\_address) | VIP IP address |
<!-- END_TF_DOCS -->
