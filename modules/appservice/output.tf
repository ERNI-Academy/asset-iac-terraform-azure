output "id" {
    value = azurerm_app_service.app.id
}

output "hostname" {
    value = "https://${azurerm_app_service.app.default_site_hostname}"
}