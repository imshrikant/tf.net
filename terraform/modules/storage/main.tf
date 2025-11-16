resource "azurerm_storage_account" "sa" {
  name                     = var.name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

output "name" {
  value = azurerm_storage_account.sa.name
}
