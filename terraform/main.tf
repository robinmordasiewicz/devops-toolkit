resource "azurerm_resource_group" "azure_resource_group" {
  #ts:skip=AC_AZURE_0389 in development we allow deletion of resource groups
  name     = random_pet.admin_username.id
  location = var.location
  tags = {
    Username = var.owner_email
  }
}

resource "random_pet" "admin_username" {
  length = 2
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

#data "github_repository" "repository" {
#    full_name = "robinmordasiewicz/devops-toolkit"
#}

#resource "github_actions_secret" "project_secret" {
#  secret_name     = "PROJECT"
#  plaintext_value = random_pet.admin_username.id
#  repository      = data.github_repository.repository.name
#}
