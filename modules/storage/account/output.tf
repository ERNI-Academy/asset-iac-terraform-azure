// ------------------------------------------------------------------------------
// output module configuration
// ------------------------------------------------------------------------------
output "storage_account_id" {
  value = azurerm_storage_account.account.id
}

output "storage_account_name" {
  value = azurerm_storage_account.account.name
}
