variable "owner_email" {
  description = "Email address for use with Azure Owner tag."
  type        = string
}

variable "location" {
  description = "Azure region for resource group."
  type        = string
}

variable "hub-virtual-network_address_prefix" {
  description = "Hub Virtual Network Address prefix."
  type        = string
}

variable "hub-internal-subnet_name" {
  description = "Hub Subnet Name."
  type        = string
}

variable "hub-internal-subnet_prefix" {
  description = "Hub Subnet Prefix."
  type        = string
}

variable "hub-external-subnet_name" {
  description = "External Subnet Name."
  type        = string
}

variable "hub-external-subnet_prefix" {
  description = "External Subnet Prefix."
  type        = string
}

variable "hub-external-subnet-gateway" {
  description = "Azure gateway IP address to the Internet"
  type        = string
}

variable "spoke-virtual-network_address_prefix" {
  description = "Spoke Virtual Network Address prefix."
  type        = string
}

variable "spoke-subnet_name" {
  description = "Spoke Subnet Name."
  type        = string
}

variable "spoke-subnet_prefix" {
  description = "Spoke Subnet Prefix."
  type        = string
}

variable "hub-nva-sku" {
  description = "Hub NVA SKU"
  type        = string
}

variable "hub-nva-publisher" {
  description = "Hub NVA Publisher"
  type        = string
}

variable "hub-nva-offer" {
  description = "Hub NVA Offer"
  type        = string
}

variable "hub-nva-size" {
  description = "Hub NVA Size"
  type        = string
}

variable "hub-nva-management-port" {
  description = "Hub NVA Management TCP Port"
  type        = string
}

variable "hub-nva-management-ip" {
  description = "Hub NVA Management IP Address"
  type        = string
}

variable "hub-nva-gateway" {
  description = "Hub NVA Gateway IP Address"
  type        = string
}

variable "hub-nva-vip" {
  description = "Hub NVA Gateway Virtual IP Address"
  type        = string
}

variable "hub-nva-management-action" {
  description = "Allow or Deny access to Management"
  type        = string
}

variable "spoke-container-server-sku" {
  description = "Spoke Container Server SKU"
  type        = string
}

variable "spoke-container-server-publisher" {
  description = "Spoke Container Server Publisher"
  type        = string
}

variable "spoke-container-server-offer" {
  description = "Spoke Container Server Offer"
  type        = string
}

variable "spoke-container-server-size" {
  description = "Spoke Container Server Size"
  type        = string
}

variable "spoke-container-server-ip" {
  description = "Spoke Container Server IP Address"
  type        = string
}

variable "spoke-check-internet-up-ip" {
  description = "Spoke Container Server Checks the Internet at this IP Address"
  type        = string
}
