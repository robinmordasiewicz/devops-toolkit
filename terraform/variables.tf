variable "owner_email" {
  description = "Email address for use with Azure Owner tag."
  type        = string
}

variable "location" {
  description = "Azure region for resource group."
  type        = string
}

variable "resource_group" {
  description = "Azure resource group."
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
