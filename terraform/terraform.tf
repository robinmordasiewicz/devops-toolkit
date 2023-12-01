terraform {
  required_version = "1.6.4"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.83.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.4.0"
    }
  }
  backend "azurerm" {
  }
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
