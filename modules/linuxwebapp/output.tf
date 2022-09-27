// ------------------------------------------------------------------------------
// output module configuration
// ------------------------------------------------------------------------------
output "id" {
  value = azurerm_linux_web_app.app.id
}

output "hostname" {
  value = "https://${azurerm_linux_web_app.app.default_hostname}"
}
