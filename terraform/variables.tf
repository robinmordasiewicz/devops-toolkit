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

variable "internal_name" {
  description = "Internal Subnet Name."
  type        = string
}

variable "internal_prefix" {
  description = "Internal Subnet Prefix."
  type        = string
}

variable "external_name" {
  description = "External Subnet Name."
  type        = string
}

variable "external_prefix" {
  description = "External Subnet Prefix."
  type        = string
}

variable "vnet_address_prefix" {
  description = "Virtual Network Address prefix."
  type        = string
}
