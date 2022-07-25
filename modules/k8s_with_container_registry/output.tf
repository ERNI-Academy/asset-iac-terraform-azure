output "container_registry_id" {
  description = "The Container Registry ID."
  value       = azurerm_container_registry.container.id
}

output "container_registry_name" {
  description = "The Container Registry name."
  value       = azurerm_container_registry.container.name
}

output "container_registry_login_server" {
  description = "The URL that can be used to log into the container registry."
  value       = azurerm_container_registry.container.login_server
}

output "container_registry_fqdn" {
  description = "The Container Registry FQDN."
  value       = azurerm_container_registry.container.login_server
}

output "container_registry_admin_username" {
  description = "The Username associated with the Container Registry Admin account - if the admin account is enabled."
  value       = azurerm_container_registry.container.admin_username
}

output "container_registry_admin_password" {
  description = "The Password associated with the Container Registry Admin account - if the admin account is enabled."
  value       = azurerm_container_registry.container.admin_password
  sensitive   = true
}

resource "local_file" "kubeconfig" {
  depends_on   = [azurerm_kubernetes_cluster.cluster]
  filename     = "kubeconfig"
  content      = azurerm_kubernetes_cluster.cluster.kube_config_raw
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.cluster.kube_config_raw
}
output "kubernetes_cluster_name" {
 value = azurerm_kubernetes_cluster.cluster.name
}