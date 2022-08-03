# Azure Function App Service

[![License](https://img.shields.io/badge/License-Apache%202.0-brightgreen.svg)](https://opensource.org/licenses/Apache-2.0)

A [Terraform](https://www.terraform.io) 0.12 module for creating
[`Azure Function App`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app) resources.

- [Azure Function App Service](#azure-function-app-service)
  - [Prerequisits](#prerequisits)
  - [Module Features](#module-features)
  - [Getting Started](#getting-started)
  - [Module Argument Reference](#module-argument-reference)
  - [Module Attributes Reference](#module-attributes-reference)
  - [Samples](#samples)

## Prerequisits

To use this module you need the following resources:

- [`Azure Resource Group`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)
- [`Azure App Service Plan`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_plan)
- [`Azure Analytics Workspace`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace)

## Module Features

This module creates [`Azure Function App`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app) resources.

## Getting Started

Most basic usage creating a [`Azure Function App`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app) resource.

```terraform
module "function" {
  source = "."

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  function_name       = "myfnapp"
  environment         = "DEV"
  law_id              = azurerm_log_analytics_workspace.law.id
  plan_id             = azurerm_app_service_plan.plan.id
  tags = {
    MyTag = "MyTag value"
  }

  depends_on = [
    azurerm_resource_group.rg,
    azurerm_log_analytics_workspace.law,
    azurerm_app_service_plan.plan
  ]
} 
```

## Module Argument Reference

See [variables.tf](variables.tf)

## Module Attributes Reference

in addition of all arguments above the following attributes are exported by the module:

- **`id`**: The create function id returned by [`Azure Function App`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app#attributes-reference) **`id`** attribute
- **`host_name`**: The created container registry name returned by [`Azure Function App`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app#attributes-reference) **`default_hostname`** attribute

## Samples

You have the samples in [samples folder](../../samples/functionsample/)
