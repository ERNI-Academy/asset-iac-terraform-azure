// ------------------------------------------------------------------------------
// output module configuration
// ------------------------------------------------------------------------------
output "id" {
  value = azurerm_function_app.fnapp.id
}

output "hostname" {
  value = "https://${azurerm_function_app.fnapp.default_hostname}"
}
