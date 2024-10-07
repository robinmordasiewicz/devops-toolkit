terraform {
  required_version = ">=1.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.6"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.4.5"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.3"
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
      version = "2.3.4"
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