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

variable "internal-subnet_name" {
  description = "Internal Subnet Name."
  type        = string
}

variable "internal-subnet_prefix" {
  description = "Internal Subnet Prefix."
  type        = string
}

variable "external-subnet_name" {
  description = "External Subnet Name."
  type        = string
}

variable "external-subnet_prefix" {
  description = "External Subnet Prefix."
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

variable "hub-vnet_address_prefix" {
  description = "Virtual Network Address prefix."
  type        = string
}

variable "spoke-vnet_address_prefix" {
  description = "Virtual Network Address prefix."
  type        = string
}
