variable "owner_email" {
  default     = "root@example.com"
  description = "Email address for use with Azure Owner tag."
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

variable "hub-nva-sku" {
  default     = "fortinet_fg-vm_payg_2023"
  description = "Hub NVA SKU"
  type        = string
  validation {
    condition     = var.hub-nva-sku == "fortinet_fg-vm_payg_2023" || var.hub-nva-sku == "fortinet_fw-vm_payg_v3"
    error_message = "The SKU must be either 'fortinet_fg-vm_payg_2023' or 'fortinet_fw-vm_payg_v3'."
  }
}

variable "hub-nva-publisher" {
  default     = "fortinet"
  description = "Hub NVA Publisher"
  type        = string
}

variable "hub-nva-offer" {
  default     = "fortinet_fortigate-vm_v5"
  description = "Hub NVA Offer"
  type        = string
  validation {
    condition     = var.hub-nva-offer == "fortinet_fortigate-vm_v5" || var.hub-nva-offer == "fortinet_fortiweb-vm_v5"
    error_message = "Invalid SKU. The SKU must be either 'fortinet_fortigate-vm_v5' or 'fortinet_fortiweb-vm_v5'."
  }
}

variable "hub-nva-size" {
  default     = "Standard_DS1_v2"
  description = "Hub NVA Size"
  type        = string
}

variable "hub-nva-management-port" {
  default     = "443"
  description = "Hub NVA Management TCP Port"
  type        = number
  validation {
    condition = (
      can(tonumber(var.hub-nva-management-port)) &&
      tonumber(var.hub-nva-management-port) >= 1 &&
      tonumber(var.hub-nva-management-port) <= 65433
    )
    error_message = "The port number must be an integer between 1 and 65433."
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
    condition     = var.hub-nva-management-action == "Accept" || var.hub-nva-management-action == "Deny"
    error_message = "The management action must be either 'Accept' or 'Deny'."
  }
}

variable "spoke-virtual-network_address_prefix" {
  default     = "10.1.1.0/24"
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

variable "spoke-container-server-sku" {
  default     = "22_04-lts-gen2"
  description = "Spoke Container Server SKU"
  type        = string
}

variable "spoke-container-server-publisher" {
  default     = "Canonical"
  description = "Spoke Container Server Publisher"
  type        = string
}

variable "spoke-container-server-offer" {
  default     = "0001-com-ubuntu-server-jammy"
  description = "Spoke Container Server Offer"
  type        = string
}

variable "spoke-container-server-size" {
  default     = "Standard_DS1_v2"
  description = "Spoke Container Server Size"
  type        = string
}

variable "spoke-container-server-ip" {
  default     = "10.1.1.5"
  description = "Spoke Container Server IP Address"
  type        = string
  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.spoke-container-server-ip))
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
