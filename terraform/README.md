# Fortinet Azure Terraform

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
subgraph "n0"["Compute"]
n1["azurerm_availability_set.<br/>fortinet_availability_set"]:::r
n2["azurerm_linux_virtual_machine.<br/>fortigate_virtual_machine"]:::r
end
class n0 cs
subgraph "n3"["Network"]
n4["azurerm_network_interface.<br/>fortigate_dmz_network_interface"]:::r
n5["azurerm_network_interface.<br/>fortigate_external_network_interface"]:::r
n6["azurerm_network_interface_security_group_association.<br/>fortigate_association"]:::r
n7["azurerm_network_security_group.<br/>nsg"]:::r
n8["azurerm_network_security_group.<br/>private_nsg"]:::r
n9["azurerm_network_security_group.<br/>vip_allow_https_tcp_nsg"]:::r
na["azurerm_public_ip.<br/>fortigate_public_ip"]:::r
nb["azurerm_public_ip.<br/>vip_public_ip"]:::r
nc["azurerm_subnet.dmz_subnet"]:::r
nd["azurerm_subnet.<br/>external_subnet"]:::r
ne["azurerm_subnet.<br/>internal_subnet"]:::r
nf["azurerm_subnet_network_security_group_association.<br/>dmz_subnet_association"]:::r
ng["azurerm_subnet_network_security_group_association.<br/>external_subnet_association"]:::r
nh["azurerm_subnet_network_security_group_association.<br/>internal_subnet_association"]:::r
ni["azurerm_virtual_network.vnet"]:::r
end
class n3 cs
subgraph "nj"["Base"]
nk["azurerm_resource_group.<br/>azure_resource_group"]:::r
end
class nj cs
nl["random_integer.random_number"]:::r
nm["random_pet.admin_username"]:::r
nn["tls_private_key.ssh_key"]:::r
nk-->n1
n1-->n2
n4-->n2
n5-->n2
nm-->n2
nn-->n2
nc-->n4
nb-->n5
nd-->n5
n5-->n6
n9-->n6
nk-->n7
nk-->n8
nk-->n9
nk-->na
nk-->nb
ni-->nc
ni-->nd
ni-->ne
n8-->nf
nc-->nf
n8-->ng
nd-->ng
n8-->nh
ne-->nh
nk-->ni
nk-->nm
```

<!-- BEGIN_TF_DOCS -->
## Example terraform.auto.tfvars

```hcl
location            = "canadacentral"
resource_group      = "my-resource-group"
owner_email         = "root@example.com"
vnet_address_prefix = "10.0.0.0/16"
external_name       = "external"
external_prefix     = "10.0.1.0/24"
dmz_name            = "dmz"
dmz_prefix          = "10.0.2.0/24"
internal_name       = "internal"
internal_prefix     = "10.0.3.0/24"
```


## Requirements

| Name | Version |
|------|---------|
| terraform | 1.6.4 |
| azurerm | 3.81.0 |
| http | 3.4.0 |
| random | 3.5.1 |
| tls | 4.0.4 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dmz\_name | DMZ Subnet Name. | `string` | n/a | yes |
| dmz\_prefix | DMZ Subnet Prefix. | `string` | n/a | yes |
| external\_name | External Subnet Name. | `string` | n/a | yes |
| external\_prefix | External Subnet Prefix. | `string` | n/a | yes |
| internal\_name | Internal Subnet Name. | `string` | n/a | yes |
| internal\_prefix | Internal Subnet Prefix. | `string` | n/a | yes |
| location | Azure region for resource group. | `string` | n/a | yes |
| owner\_email | Email address for use with Azure Owner tag. | `string` | n/a | yes |
| resource\_group | Unique name of the Azure resource group. | `string` | n/a | yes |
| vnet\_address\_prefix | Virtual Network Address prefix. | `string` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| admin\_username | Username for admin account |
| fortigate\_public\_ip\_address | Management IP address |
| terraform\_version | Terraform Version |
| tls\_private\_key | TSL private key |
| vip\_public\_ip\_address | Public IP address |

<!-- END_TF_DOCS -->
