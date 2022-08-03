// This module creates an ACR (https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry)
// Those resources are needed to be created previusly:
// 1- Resource Group -> to hold the resources

locals {
  container_name = "${var.container_name}${var.environment}"
}

resource "azurerm_container_registry" "container" {
  name                          = local.container_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.container_sku
  admin_enabled                 = var.container_admin_enabled
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags
}
