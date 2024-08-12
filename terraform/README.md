#Hub NVA

- Microsoft Azure publishes NVA deployment use cases.
- Hub & Spoke Architecture At its core, the Hub & Spoke model is a paradigm for dataflow management. It necessitates the capacity to oversee, document, and scrutinize data traversing in all directions—be it north-to-south or east-to-west.
- As the best practice when working with AKS is to separate each cluster into different VNets
- Don't create more than one AKS cluster in the same subnet.
- Try to follow best practices.

https://learn.microsoft.com/en-us/azure/architecture/networking/guide/nva-ha#pip-udr-nvas-without-snat

## Changing PIP/UDR

![Changing PIP/UDR](https://learn.microsoft.com/en-us/azure/architecture/networking/guide/images/nvaha-pipudr-internet.png)

## Sizing

https://learn.microsoft.com/en-us/azure/virtual-machines/fsv2-series

## Marketplace SKUs

```bash
az vm image list --publisher fortinet --all
```

<!-- BEGIN_TF_DOCS -->
## terraform.auto.tfvars

```hcl
location                             = "canadacentral"
owner_email                          = "root@example.com"
hub-nva-image                        = "fortiweb"
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
spoke-virtual-network_address_prefix = "10.1.0.0/16"
spoke-subnet_name                    = "spoke_subnet"
spoke-subnet_prefix                  = "10.1.1.0/24"
spoke-aks-subnet_name                = "spoke_aks_subnet"
spoke-aks-subnet_prefix              = "10.1.2.0/24"
spoke-aks_dns_service_ip             = "10.1.2.10"
spoke-check-internet-up-ip           = "8.8.8.8"
spoke-aks-node-ip                    = "10.1.1.4"
spoke-aks-node-image-gpu             = false
spoke-k8s-node-pool-gpu              = false



## Requirements

| Name | Version |
|------|---------|
| terraform | >=1.6 |
| azurerm | 3.114.0 |
| external | 2.3.3 |
| git | 0.1.0 |
| http | 3.4.4 |
| local | 2.5.1 |
| null | 3.2.2 |
| random | 3.6.2 |
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
| owner\_email | Email address for use with Owner tag. | `string` | `"root@example.com"` | no |
| spoke-aks-subnet\_name | Spoke aks Subnet Name. | `string` | `"spoke-aks-subnet_name"` | no |
| spoke-aks-subnet\_prefix | Spoke Pod Subnet Prefix. | `string` | `"10.1.2.0/24"` | no |
| spoke-check-internet-up-ip | Spoke Container Server Checks the Internet at this IP Address | `string` | `"8.8.8.8"` | no |
| spoke-k8s-node-pool-gpu | Set to true to enable GPU workloads | `bool` | `false` | no |
| spoke-k8s-node-pool-image | k8s node pool image. | `bool` | `false` | no |
| spoke-k8s\_service\_cidr | Spoke k8s service cidr. | `string` | `"10.1.2.0/24"` | no |
| spoke-ks8\_dns\_service\_ip | Spoke k8s dns service ip | `string` | `"10.2.0.10"` | no |
| spoke-linux-server-image | Container server image product | `string` | `"linux-server"` | no |
| spoke-linux-server-image-gpu | Set to true to enable GPU workloads | `bool` | `false` | no |
| spoke-linux-server-ip | Spoke Container Server IP Address | `string` | `"10.1.1.5"` | no |
| spoke-linux-server-ollama-port | Port for ollama | `string` | `"11434"` | no |
| spoke-linux-server-ollama-webui-port | Port for the ollama web ui | `string` | `"8080"` | no |
## Outputs

| Name | Description |
|------|-------------|
| admin\_password | Password for admin account |
| admin\_username | Username for admin account |
| etc\_host | The public IP address of the hub NVA. |
| management\_fqdn | Management FQDN |
| resource\_group\_url | URL to access the Azure Resource Group in the Azure Portal |
| vip\_fqdn | VIP FQDN |
<!-- END_TF_DOCS -->
