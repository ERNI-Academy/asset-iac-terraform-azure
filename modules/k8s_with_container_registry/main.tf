// This module creates an AKS & ACS & role assignament
// Those resources are needed to be created previusly:
// 1- Resource Group -> to hold the resources

locals {
 container_name = "${var.container_name}${var.environment}" 
 k8s_name = "${var.k8s_name}-${var.environment}"
 dns_name = "${var.k8s_name}-${var.environment}"
}

resource "azurerm_container_registry" "container" {
  name                = local.container_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.container_sku
  admin_enabled       = var.container_admin_enabled
  public_network_access_enabled = var.public_network_access_enabled
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = local.k8s_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = local.dns_name
  

  default_node_pool {
    name       = var.default_node_pool_name
    node_count = var.default_node_pool_node_count
    vm_size    = var.default_node_pool_vm_size
    os_disk_size_gb = var.default_node_pool_disk_size_gb
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "role" {
  principal_id                     = azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id 
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.container.id
  skip_service_principal_aad_check = true
}