# Azure Storage Account

[![License](https://img.shields.io/badge/License-Apache%202.0-brightgreen.svg)](https://opensource.org/licenses/Apache-2.0)

A [Terraform](https://www.terraform.io) 0.12 module for creating
[`Azure storage account`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) resources.
.

- [Azure Storage Account](#azure-storage-account)
  - [Module Features](#module-features)
  - [Getting Started](#getting-started)
  - [Module Argument Reference](#module-argument-reference)
  - [Module Attributes Reference](#module-attributes-reference)

## Module Features

This module creates a [`Azure storage account`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) resources.

## Getting Started

Most basic usage creating a [`Azure storage account`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) resource and an [`Azure storage account`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) resource.

```terraform
module "account" {
  source                   = "."
  environment              = "development"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_name             = "accountsample"
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags = {
    environment = "Demo"
  }
}
```

## Module Argument Reference

See [variables.tf](variables.tf)

## Module Attributes Reference

in addition of all arguments above the following attributes are exported by the module:

- **`storage_account_id`**: A single null resource object as returned by [`Azure storage account`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#attributes-reference) **`id`** attribute
- **`storage_account_name`**: A list of null resource objects as returned by [`Azure storage account`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#attributes-reference) **`name`** attribute
