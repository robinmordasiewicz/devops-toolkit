variable "subscription_id" {
  description = "Azure subscription ID"
  type = string
}

variable "owner_email" {
  default     = "root@example.com"
  description = "Email address for use with Owner tag."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.owner_email))
    error_message = "The owner_email must be a valid email address."
  }
}

variable "location" {
  default     = "canadacentral"
  description = "Azure region for resource group."
  type        = string
  validation {
    condition = contains(
      [
        "asia",
        "asiapacific",
        "australia",
        "australiacentral",
        "australiacentral2",
        "australiaeast",
        "australiasoutheast",
        "brazil",
        "brazilsouth",
        "brazilsoutheast",
        "brazilus",
        "canada",
        "canadacentral",
        "canadaeast",
        "centralindia",
        "centralus",
        "centraluseuap",
        "centralusstage",
        "eastasia",
        "eastus",
        "eastus2",
        "eastus2euap",
        "eastusstage",
        "eastusstg",
        "europe",
        "france",
        "francecentral",
        "francesouth",
        "germany",
        "germanynorth",
        "germanywestcentral",
        "global",
        "india",
        "israel",
        "israelcentral",
        "italy",
        "italynorth",
        "japan",
        "japaneast",
        "japanwest",
        "jioindiawest",
        "jioindiacentral",
        "korea",
        "koreacentral",
        "koreasouth",
        "mexicocentral",
        "newzealand",
        "northeurope",
        "norway",
        "norwayeast",
        "norwaywest",
        "northcentralus",
        "northcentralusstage",
        "poland",
        "polandcentral",
        "qatar",
        "qatarcentral",
        "singapore",
        "southafrica",
        "southafricanorth",
        "southafricawest",
        "southcentralus",
        "southcentralusstage",
        "southindia",
        "southeastasia",
        "southeastasiastage",
        "sweden",
        "swedencentral",
        "switzerland",
        "switzerlandnorth",
        "switzerlandwest",
        "uae",
        "uaecentral",
        "uaenorth",
        "uk",
        "ukwest",
        "unitedstates",
        "unitedstateseuap",
        "uksouth",
        "westcentralus",
        "westeurope",
        "westindia",
        "westus",
        "westus2",
        "westus2stage",
        "westusstage"
    ], var.location)
    error_message = "The Azure location must be one of the allowed Azure regions."
  }
}

variable "hub-virtual-network_address_prefix" {
  default     = "10.0.0.0/24"
  description = "Hub Virtual Network Address prefix."
  type        = string
  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])/(3[0-2]|[12]?[0-9])$", var.hub-virtual-network_address_prefix))
    error_message = "The subnet must be in the format of 'xxx.xxx.xxx.xxx/xx', where xxx is between 0 and 255, and xx is between 0 and 32."
  }
}

variable "hub-internal-subnet_name" {
  default     = "hub-internal_subnet"
  description = "Hub Subnet Name."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]*$", var.hub-internal-subnet_name))
    error_message = "The value must consist of alphanumeric characters, underscores, or dashes only."
  }
}

variable "hub-internal-subnet_prefix" {
  default     = "10.0.0.32/27"
  description = "Hub Subnet Prefix."
  type        = string
  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])/(3[0-2]|[12]?[0-9])$", var.hub-internal-subnet_prefix))
    error_message = "The subnet must be in the format of 'xxx.xxx.xxx.xxx/xx', where xxx is between 0 and 255, and xx is between 0 and 32."
  }
}

variable "hub-external-subnet_name" {
  default     = "hub-external_subnet"
  description = "External Subnet Name."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]*$", var.hub-external-subnet_name))
    error_message = "The value must consist of alphanumeric characters, underscores, or dashes only."
  }
}

variable "hub-external-subnet_prefix" {
  default     = "10.0.0.0/27"
  description = "External Subnet Prefix."
  type        = string
  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])/(3[0-2]|[12]?[0-9])$", var.hub-external-subnet_prefix))
    error_message = "The subnet must be in the format of 'xxx.xxx.xxx.xxx/xx', where xxx is between 0 and 255, and xx is between 0 and 32."
  }
}

variable "hub-external-subnet-gateway" {
  default     = "10.0.0.1"
  description = "Azure gateway IP address to the Internet"
  type        = string
  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.hub-external-subnet-gateway))
    error_message = "The IP address must be a valid IPv4 format (e.g., 192.168.1.1)."
  }
}

variable "hub-nva-image" {
  default     = "fortigate"
  description = "NVA image product"
  type        = string
  validation {
    condition     = var.hub-nva-image == "fortigate" || var.hub-nva-image == "fortiweb" || var.hub-nva-image == "fortiadc"
    error_message = "The SKU must be either 'fortiweb', 'fortigate', or 'fortiadc'"
  }
}

variable "hub-nva-management-ip" {
  default     = "10.0.0.4"
  description = "Hub NVA Management IP Address"
  type        = string
  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.hub-nva-management-ip))
    error_message = "The IP address must be a valid IPv4 format (e.g., 10.0.0.4)."
  }
}

variable "hub-nva-gateway" {
  default     = "10.0.0.37"
  description = "Hub NVA Gateway IP Address"
  type        = string
  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.hub-nva-gateway))
    error_message = "The IP address must be a valid IPv4 format (e.g., 10.0.0.37)."
  }
}

variable "hub-nva-vip" {
  default     = "10.0.0.5"
  description = "Hub NVA Gateway Virtual IP Address"
  type        = string
  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.hub-nva-vip))
    error_message = "The IP address must be a valid IPv4 format (e.g., 10.0.0.5)."
  }
}

variable "hub-nva-management-action" {
  default     = "Deny"
  description = "Allow or Deny access to Management"
  type        = string
  validation {
    condition     = var.hub-nva-management-action == "Allow" || var.hub-nva-management-action == "Deny"
    error_message = "The management action must be either 'Allow' or 'Deny'."
  }
}

variable "spoke-aks-node-image" {
  default     = "aks-node"
  description = "Container server image product"
  type        = string
}

#variable "spoke-aks-node-image-gpu" {
#  default     = false
#  description = "Set to true to enable GPU workloads"
#  type        = bool
#}

variable "spoke-k8s-node-pool-gpu" {
  default     = false
  description = "Set to true to enable GPU workloads"
  type        = bool
}

variable "spoke-k8s-node-pool-image" {
  default     = false
  description = "k8s node pool image."
  type        = bool
}

variable "spoke-virtual-network_address_prefix" {
  default     = "10.1.0.0/16"
  description = "Spoke Virtual Network Address prefix."
  type        = string
  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])/(3[0-2]|[12]?[0-9])$", var.spoke-virtual-network_address_prefix))
    error_message = "The subnet must be in the format of 'xxx.xxx.xxx.xxx/xx', where xxx is between 0 and 255, and xx is between 0 and 32."
  }
}

variable "spoke-subnet_name" {
  default     = "spoke_subnet"
  description = "Spoke Subnet Name."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]*$", var.spoke-subnet_name))
    error_message = "The value must consist of alphanumeric characters, underscores, or dashes only."
  }
}

variable "spoke-subnet_prefix" {
  default     = "10.1.1.0/24"
  description = "Spoke Subnet Prefix."
  type        = string
  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])/(3[0-2]|[12]?[0-9])$", var.spoke-subnet_prefix))
    error_message = "The subnet must be in the format of 'xxx.xxx.xxx.xxx/xx', where xxx is between 0 and 255, and xx is between 0 and 32."
  }
}
variable "spoke-aks-subnet_name" {
  default     = "spoke-aks-subnet"
  description = "Spoke aks Subnet Name."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]*$", var.spoke-aks-subnet_name))
    error_message = "The value must consist of alphanumeric characters, underscores, or dashes only."
  }
}

variable "spoke-aks-subnet_prefix" {
  default     = "10.1.2.0/24"
  description = "Spoke Pod Subnet Prefix."
  type        = string
  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])/(3[0-2]|[12]?[0-9])$", var.spoke-aks-subnet_prefix))
    error_message = "The subnet must be in the format of 'xxx.xxx.xxx.xxx/xx', where xxx is between 0 and 255, and xx is between 0 and 32."
  }
}

variable "spoke-aks_service_cidr" {
  default     = "10.1.2.0/24"
  description = "Spoke k8s service cidr."
  type        = string
  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])/(3[0-2]|[12]?[0-9])$", var.spoke-aks_service_cidr))
    error_message = "The subnet must be in the format of 'xxx.xxx.xxx.xxx/xx', where xxx is between 0 and 255, and xx is between 0 and 32."
  }
}

variable "spoke-aks_pod_cidr" {
  default     = "10.244.0.0/16"
  description = "Spoke k8s pod cidr."
  type        = string
  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])/(3[0-2]|[12]?[0-9])$", var.spoke-aks_pod_cidr))
    error_message = "The subnet must be in the format of 'xxx.xxx.xxx.xxx/xx', where xxx is between 0 and 255, and xx is between 0 and 32."
  }
}

variable "spoke-aks_dns_service_ip" {
  default     = "10.1.2.10"
  description = "Spoke k8s dns service ip"
  type        = string
  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.spoke-aks_dns_service_ip))
    error_message = "The IP address must be a valid IPv4 format (e.g., 10.2.0.10)."
  }
}

variable "spoke-aks-node-ip" {
  default     = "10.1.1.4"
  description = "Spoke Container Server IP Address"
  type        = string
  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.spoke-aks-node-ip))
    error_message = "The IP address must be a valid IPv4 format (e.g., 10.1.1.5)."
  }
}

variable "spoke-check-internet-up-ip" {
  default     = "8.8.8.8"
  description = "Spoke Container Server Checks the Internet at this IP Address"
  type        = string
  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.spoke-check-internet-up-ip))
    error_message = "The IP address must be a valid IPv4 format (e.g., 8.8.8.8)."
  }
}

variable "spoke-aks-node-ollama-port" {
  default     = "11434"
  description = "Port for ollama"
  type        = string
}

variable "spoke-aks-node-ollama-webui-port" {
  default     = "8080"
  description = "Port for the ollama web ui"
  type        = string
}
