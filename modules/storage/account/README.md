# Azure Storage Account

A [Terraform](https://www.terraform.io) module for creating
[`Azure storage account`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) resources.
.

- [Azure Storage Account](#azure-storage-account)
  - [Prerequisits](#prerequisits)
  - [Module Features](#module-features)
  - [Getting Started](#getting-started)
  - [Module Argument Reference](#module-argument-reference)
  - [Module Attributes Reference](#module-attributes-reference)
  - [Samples](#samples)

## Prerequisits

To use this module you need the following resources:

- [`Azure Resource Group`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)

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

- **`storage_account_id`**: The id of the created storage account returned by [`Azure storage account`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#attributes-reference) **`id`** attribute
- **`storage_account_name`**: The name of the created storage account returned by [`Azure storage account`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#attributes-reference) **`name`** attribute
- **`primary_access_key`**: The primary access key for the created storage account returned by [`Azure storage account`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#attributes-reference) **`primary_access_key`** attribute
- **`secondary_access_key`**: The secondary access key for the created storage account returned by [`Azure storage account`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#attributes-reference) **`secondary_access_key`** attribute

## Samples

You have the samples in [samples folder](../../../samples/storage/account/)