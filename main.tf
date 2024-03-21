# Create a Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "tp3"
  location = "France Central (Zone 1)"
}