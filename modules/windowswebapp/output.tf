// ------------------------------------------------------------------------------
// output module configuration
// ------------------------------------------------------------------------------
output "id" {
  value = azurerm_windows_web_app.app.id
}

output "hostname" {
  value = "https://${azurerm_windows_web_app.app.default_hostname}"
}
