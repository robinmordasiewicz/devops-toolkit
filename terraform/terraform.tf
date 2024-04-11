terraform {
  required_version = "1.7.5"
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.97.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.4.1"
    }
  }
  # backend "azurerm" {}
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  skip_provider_registration = true
}

provider "random" {}
provider "tls" {}
provider "http" {}
