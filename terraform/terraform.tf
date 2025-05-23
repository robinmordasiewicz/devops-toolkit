terraform {
  required_version = ">=1.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.28.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.1.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.5.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.4"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.2"
    }
    git = {
      source  = "paultyng/git"
      version = "0.1.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "2.3.5"
    }
  }
  # backend "azurerm" {}
}

data "azurerm_subscription" "current" {
}

data "azurerm_client_config" "current" {
}

provider "azurerm" {
  features {
    api_management {
      purge_soft_delete_on_destroy = true
      recover_soft_deleted         = false
    }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = var.subscription_id
  #resource_provider_registrations = "none"
}

provider "random" {}
provider "tls" {}
provider "http" {}
provider "local" {}
provider "git" {}