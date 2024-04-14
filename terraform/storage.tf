resource "random_id" "random_id" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.azure_resource_group.name
  }

  byte_length = 8
}
# Create storage account for boot diagnostics
resource "azurerm_storage_account" "my_storage_account" {
  name                     = "diag${random_id.random_id.hex}"
  location                 = azurerm_resource_group.azure_resource_group.location
  resource_group_name      = azurerm_resource_group.azure_resource_group.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
