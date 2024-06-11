terraform {
  required_version = ">=1.6"
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    argocd = {
      source = "oboukili/argocd"
      version = "6.1.1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.107.0"
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
      version = "3.4.3"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.13.2"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.30.0"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
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
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
provider "kubectl" {}
provider "argocd" {
  core = true
}
