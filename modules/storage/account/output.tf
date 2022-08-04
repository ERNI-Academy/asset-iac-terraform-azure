// ------------------------------------------------------------------------------
// output module configuration
// ------------------------------------------------------------------------------
output "storage_account_id" {
  value = azurerm_storage_account.account.id
}

output "storage_account_name" {
  value = azurerm_storage_account.account.name
}

output "primary_access_key" {
  value = azurerm_storage_account.account.primary_access_key
}

output "secondary_access_key" {
  value = azurerm_storage_account.account.secondary_access_key
}
