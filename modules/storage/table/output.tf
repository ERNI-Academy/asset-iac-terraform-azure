// ------------------------------------------------------------------------------
// output module configuration
// ------------------------------------------------------------------------------
output "storage_account_id" {
  value = var.account_id == "" ? module.storage_account[0].storage_account_id : var.account_id
}

output "storage_account_name" {
  value = var.account_id == "" ? module.storage_account[0].storage_account_name : local.account_name
}

output "storage_table_id" {
  value = azurerm_storage_table.table.id
}

output "storage_table_name" {
  value = azurerm_storage_table.table.name
}
