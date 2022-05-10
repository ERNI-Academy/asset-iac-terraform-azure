output "id" {
    value = azurerm_function_app.fnapp.id
}

output "hostName" {
    value = "https://${azurerm_function_app.fnapp.default_hostname}"
}