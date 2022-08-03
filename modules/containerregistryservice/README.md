# Azure Container Registry Service

[![License](https://img.shields.io/badge/License-Apache%202.0-brightgreen.svg)](https://opensource.org/licenses/Apache-2.0)

A [Terraform](https://www.terraform.io) 0.12 module for creating
[`Azure Container Registry Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) resources.

- [Azure Container Registry Service](#azure-container-registry-service)
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

This module creates [`Azure Container Registry Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) resources.

## Getting Started

Most basic usage creating a [`Azure Container Registry Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) resource.

```terraform
module "container" {
  source                        = "."
  environment                   = "development"
  container_name                = "containerSample"
  resource_group_name            = azurerm_resource_group.rg.name
  location                       = azurerm_resource_group.rg.location
  container_sku                 = "Basic"
  container_admin_enabled       = true
  public_network_access_enabled = false  
  tags = {
    environment = "Demo"
  }
}
```

## Module Argument Reference

See [variables.tf](variables.tf)

## Module Attributes Reference

in addition of all arguments above the following attributes are exported by the module:

- **`container_registry_id`**: The create container registry id returned by [`Azure Container Registry Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#attributes-reference) **`container_registry_id`** attribute
- **`container_registry_name`**: The created container registry name returned by [`Azure Container Registry Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#attributes-reference) **`container_registry_id`** attribute
- **`container_registry_login_server`**: The url to connect with the created container registry service returned by [`Azure Container Registry Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#attributes-reference) **`container_registry_login_server`** attribute
- **`container_registry_fqdn`**: The FQDN of the created container registry service returned by [`Azure Container Registry Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#attributes-reference) **`container_registry_fqdn`** attribute
- **`container_registry_admin_username`**: The Username associated with the Container Registry Admin account - if the admin account is enabled, returned by [`Azure Container Registry Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#attributes-reference) **`container_registry_admin_username`** attribute
- **`container_registry_admin_password`**: The Password associated with the Container Registry Admin account - if the admin account is enabled, returned by [`Azure Container Registry Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#attributes-reference) **`container_registry_admin_password`** attribute

## Samples

You have the samples in [samples folder](../../samples/container_registry/)
