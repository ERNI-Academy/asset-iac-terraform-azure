output "azurerm_public_ip" {
  value = azurerm_linux_virtual_machine.myvm.public_ip_address
}
output "domain_name_label" {
  value = azurerm_public_ip.myip.domain_name_label
}
output "public_fqdn" {
  value = azurerm_public_ip.myip.fqdn
}