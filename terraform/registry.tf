resource "azurerm_container_registry" "container-registry" {
  name                          = random_pet.admin_username.id
  resource_group_name           = azurerm_resource_group.azure_resource_group.name
  location                      = azurerm_resource_group.azure_resource_group.location
  sku                           = "Premium"
  admin_enabled                 = true
  public_network_access_enabled = true
  anonymous_pull_enabled        = true
}

data "azurerm_container_registry" "container-registry" {
  depends_on          = [azurerm_container_registry.container-registry]
  name                = random_pet.admin_username.id
  resource_group_name = azurerm_resource_group.azure_resource_group.name
}
