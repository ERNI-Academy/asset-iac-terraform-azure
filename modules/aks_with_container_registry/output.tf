// ------------------------------------------------------------------------------
// output module configuration
// ------------------------------------------------------------------------------
output "container_registry_id" {
  description = "The Container Registry ID."
  value       = module.container.container_registry_id
}

output "container_registry_name" {
  description = "The Container Registry name."
  value       = module.container.container_registry_name
}

output "container_registry_login_server" {
  description = "The URL that can be used to log into the container registry."
  value       = module.container.container_registry_login_server
}

output "container_registry_fqdn" {
  description = "The Container Registry FQDN."
  value       = module.container.container_registry_fqdn
}

output "container_registry_admin_username" {
  description = "The Username associated with the Container Registry Admin account - if the admin account is enabled."
  value       = module.container.container_registry_admin_username
}

output "container_registry_admin_password" {
  description = "The Password associated with the Container Registry Admin account - if the admin account is enabled."
  value       = module.container.container_registry_admin_password
  sensitive   = true
}

resource "local_file" "kubeconfig" {
  depends_on = [module.aks]
  filename   = "kubeconfig"
  content    = module.aks.kube_config
}

output "kube_config" {
  value = module.aks.kube_config
}
output "kubernetes_cluster_name" {
  value = module.aks.kubernetes_cluster_name
}
