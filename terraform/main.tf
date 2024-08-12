resource "azurerm_resource_group" "azure_resource_group" {
  #ts:skip=AC_AZURE_0389 in development we allow deletion of resource groups
  name     = random_pet.admin_username.id
  location = var.location
  tags = {
    Username = var.owner_email
  }
  lifecycle {
    ignore_changes = [
      tags["CreatedOnDate"],
    ]
  }
}

data "external" "tenant_default_domain" {
  program = ["sh", "-c", "az account show --query tenantDefaultDomain --output json | jq -r '{tenantDefaultDomain: .}'"]
}

output "resource_group_url" {
  value       = "https://portal.azure.com/#@${data.external.tenant_default_domain.result["tenantDefaultDomain"]}/resource${azurerm_resource_group.azure_resource_group.id}"
  description = "URL to access the Azure Resource Group in the Azure Portal"
}

resource "random_pet" "admin_username" {
  length    = 2
  separator = ""
}

resource "random_password" "admin_password" {
  keepers = {
    resource_group_name = azurerm_resource_group.azure_resource_group.name
  }
  length      = 16
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  #min_special = 1
  special = false
}
