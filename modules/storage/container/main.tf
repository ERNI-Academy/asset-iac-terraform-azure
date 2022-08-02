// This module creates an storage account (https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container)
// Those resources are needed to be created previusly:
// 1- Resource Group -> to hold the resources
// 2- Storage account if is not created previously the module can create it

locals {
  account_name   = "${var.account_name}${var.environment}"
  container_name = "${var.container_name}-${var.environment}"
  create_account = var.account_id == "" ? true : false
}

module "create_account_module" {
  source         = "../../terraform-null-resource"
  module_enabled = local.create_account
}

module "storage_account" {
  count                    = module.create_account_module.module_enabled ? 1 : 0
  source                   = "../account"
  environment              = var.environment
  account_name             = var.account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_kind             = var.account_kind
  account_replication_type = var.account_replication_type
  tags                     = var.tags
  depends_on = [
    module.create_account_module.module_enabled
  ]
}

resource "azurerm_storage_container" "container" {
  name                  = local.container_name
  storage_account_name  = module.create_account_module.module_enabled ? local.account_name : var.account_name
  container_access_type = var.container_access_type
  depends_on = [
    module.storage_account
  ]
}
