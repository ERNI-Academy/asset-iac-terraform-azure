// This module creates an AKS & ACS & role assignament
// Those resources are needed to be created previusly:
// 1- Resource Group -> to hold the resources

module "container" {
  source                        = "../containerregistryservice"
  container_name                = var.container_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  container_sku                 = var.container_sku
  container_admin_enabled       = var.container_admin_enabled
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags
  environment                   = var.environment

}

module "aks" {
  source                         = "../aks/"
  k8s_name                       = var.k8s_name
  environment                    = var.environment
  location                       = var.location
  resource_group_name            = var.resource_group_name
  default_node_pool_name         = var.default_node_pool_name
  default_node_pool_node_count   = var.default_node_pool_node_count
  default_node_pool_vm_size      = var.default_node_pool_vm_size
  default_node_pool_disk_size_gb = var.default_node_pool_disk_size_gb
  identity_type                  = var.identity_type
  identity_ids                   = var.identity_ids
  automatic_channel_upgrade      = var.automatic_channel_upgrade
  tags                           = var.tags
}

resource "azurerm_role_assignment" "role" {
  principal_id                     = module.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = module.container.container_registry_id
  skip_service_principal_aad_check = true
}
