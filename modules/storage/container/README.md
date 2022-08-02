# Azure Storage Container

[![License](https://img.shields.io/badge/License-Apache%202.0-brightgreen.svg)](https://opensource.org/licenses/Apache-2.0)

A [Terraform](https://www.terraform.io) 0.12 module for creating
[`Azure storage container`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) resources.
.

- [Azure Storage Container](#azure-storage-container)
  - [Module Features](#module-features)
  - [Getting Started](#getting-started)
  - [Module Argument Reference](#module-argument-reference)
  - [Module Attributes Reference](#module-attributes-reference)

## Module Features

This module creates a [`Azure storage container`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) resources and [`Azure storage account`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) resource if needed.

## Getting Started

Most basic usage creating a [`Azure storage container`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) resource and [`Azure storage account`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account).

```terraform
module "container" {
  source                   = "."
  account_id               = azurerm_storage_account.account.id
  account_name             = azurerm_storage_account.account.name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  environment              = "development"
  container_name           = "container"
  container_access_type    = "private"
  tags = {
    environment = "Demo"
  }
}
```

Creating a [`Azure storage container`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) resource and [`Azure storage account`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) and also an Azure Storage Account

```terraform
module "container" {
  source                   = "."
  account_name             = "accountsample"
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  environment              = "development"
  container_name           = "container"
  container_access_type    = "private"
  tags = {
    environment = "Demo"
  }
}
```

## Module Argument Reference

See [variables.tf](variables.tf)

## Module Attributes Reference

in addition of all arguments above the following attributes are exported by the module:

- **`storage_account_id`**: A single null resource object as returned by [`Azure Storage Account`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#attributes-reference) **`id`** attribute
- **`storage_account_name`**: A list of null resource objects as returned by [`Azure Storage Account`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#attributes-reference) **`name`** attribute
- **`storage_container_id`**: A single null resource object as returned by [`Azure Storage Container`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container#attributes-reference) **`id`** attribute
- **`storage_container_name`**: A list of null resource objects as returned by [`Azure Storage Container`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container#attributes-reference) **`name`** attribute
