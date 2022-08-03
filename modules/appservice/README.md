# Azure App Service

A [Terraform](https://www.terraform.io) module for creating
[`Azure App Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service) resources with [`Azure Applicaiton Insights`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) component.

- [Azure App Service](#azure-app-service)
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

This module creates
[`Azure App Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service) resources with [`Azure Applicaiton Insights`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) component.

## Getting Started

Most basic usage creating a
[`Azure App Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service) resources with [`Azure Applicaiton Insights`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) component.

```terraform
resource "azurerm_app_service_plan" "appplan" {
  name                = "api-appserviceplan-pro"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_log_analytics_workspace" "loganalyticsworkspace" {
  name                = "acctest-01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "appservice" {
  source = "."

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  app_name            = "myapp"
  environment         = "DEV"
  plan_id             = azurerm_app_service_plan.appplan.id
  law_id              = azurerm_log_analytics_workspace.loganalyticsworkspace.id

  tags = {
    MyTag = "MyTag value"
  }

  depends_on = [
    azurerm_resource_group.rg
    azurerm_app_service_plan.appplan
    azurerm_log_analytics_workspace.loganalyticsworkspace
  ]
} 
```

## Module Argument Reference

See [variables.tf](variables.tf)

## Module Attributes Reference

in addition of all arguments above the following attributes are exported by the module:

- **`id`**: The id of the created App Service returned by [`Azure App Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service#attributes-reference) **`id`** attribute
- **`hostname`**: The URL of the created App Service returned by [`Azure App Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service#attributes-reference) **`hostname`** attribute

## Samples

You have the samples in [samples folder](../../samples/appservicesample/)
