# Azure Storage Table

[![License](https://img.shields.io/badge/License-Apache%202.0-brightgreen.svg)](https://opensource.org/licenses/Apache-2.0)

A [Terraform](https://www.terraform.io) 0.12 module for creating
[`Azure Storage Table`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) resources.
.

- [Azure Storage Table](#azure-storage-table)
  - [Prerequisits](#prerequisits)
  - [Module Features](#module-features)
  - [Getting Started](#getting-started)
  - [Module Argument Reference](#module-argument-reference)
  - [Module Attributes Reference](#module-attributes-reference)
  - [Samples](#samples)

## Prerequisits

To use this module you need the following resources:

- [`Azure Resource Group`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)
- [`Azure storage account`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)

## Module Features

This module creates a [`Azure Storage Table`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) resources and [`Azure Storage Account`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) resources if needed.

## Getting Started

Most basic usage creating a [`Azure Storage Table`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) resource.

```terraform
module "queue" {
  source                   = "."
  account_id               = azurerm_storage_account.account.id
  account_name             = azurerm_storage_account.account.name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  environment              = "development"
  queue_name               = "queue"
  tags = {
    environment = "Demo"
  }
}
```

Creating a [`Azure Storage Table`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) resource and also an [`Azure Storage Account`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) resource

```terraform
module "queue" {
  source                   = "../../../modules/storage/queue"
  account_name             = "accountsample"
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  environment              = "development"
  queue_name               = "queue"
  tags = {
    environment = "Demo"
  }
}
```

## Module Argument Reference

See [variables.tf](variables.tf)

## Module Attributes Reference

in addition of all arguments above the following attributes are exported by the module:

- **`storage_account_id`**: The id of the created storage account returned by [`Azure Storage Account`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#attributes-reference) **`id`** attribute
- **`storage_account_name`**: The name of the created storage account returned by [`Azure Storage Account`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#attributes-reference) **`name`** attribute
- **`storage_table_id`**: The id of the created storage table returned by [`Azure Storage Queue`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table#attributes-reference) **`id`** attribute
- **`storage_table_name`**: The name of the created storage table returned by [`Azure Storage Queue`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table#attributes-reference) **`name`** attribute

## Samples

You have the samples in [samples folder](../../../samples/storage/table/)
