resource "azurerm_storage_account" "st" {
  name                     = "storageaccounttp3devops"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = "westus2"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}
