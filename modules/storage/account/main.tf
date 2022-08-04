// This module creates an storage account (https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)
// Those resources are needed to be created previusly:
// 1- Resource Group -> to hold the resources

locals {
  account_name = "${var.account_name}${var.environment}"
}

resource "azurerm_storage_account" "account" {
  name                     = local.account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_kind             = var.account_kind
  account_replication_type = var.account_replication_type
  access_tier              = var.account_access_tier
  min_tls_version          = var.min_tls_version
  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  queue_properties {
    logging { # Sensitive
      delete = var.queue_loging_delete
      read   = var.queue_loging_read
      write  = var.queue_loging_write
    }
  }
  tags = var.tags
}
