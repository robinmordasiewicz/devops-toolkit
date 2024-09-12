terraform {
  required_version = ">=1.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
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
      version = "2.5.1"
    }
    git = {
      source  = "paultyng/git"
      version = "0.1.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "2.3.4"
    }
    #kubernetes = {
    #  source  = "hashicorp/kubernetes"
    #  version = "2.31.0"
    #}
  }
  # backend "azurerm" {}
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
  skip_provider_registration = true
}

provider "random" {}
provider "tls" {}
provider "http" {}
provider "local" {}
provider "git" {}
#provider "kubernetes" {
#  config_path = local_file.kube_config.filename
#}

