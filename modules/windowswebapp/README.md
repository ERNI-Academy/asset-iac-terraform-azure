# Azure windows Web App

A [Terraform](https://www.terraform.io) module for creating
[`Azure windows Web App`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_web_app) resources with [`Azure Applicaiton Insights`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) component.

- [Azure windows Web App](#azure-windows-web-app)
  - [Prerequisites](#prerequisites)
  - [Module Features](#module-features)
  - [Getting Started](#getting-started)
  - [Module Argument Reference](#module-argument-reference)
  - [Module Attributes Reference](#module-attributes-reference)
  - [Samples](#samples)

## Prerequisites

To use this module you need the following resources:

- [`Azure Resource Group`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)
- [`Azure Service Plan`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan)

## Module Features

This module creates
[`Azure windows Web App`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_web_app) resources with [`Azure Applicaiton Insights`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) component.

## Getting Started

Most basic usage creating a
[`Azure windows Web App`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_web_app) resources with [`Azure Applicaiton Insights`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) component.

Browse to `samples/windowswebappsample` to see a functional example of usage.

## Module Argument Reference

See [variables.tf](variables.tf)

## Module Attributes Reference

in addition of all arguments above the following attributes are exported by the module:

- **`id`**: The id of the created App Service returned by [`Azure windows Web App`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_web_app#attributes-reference) **`id`** attribute
- **`hostname`**: The URL of the created App Service returned by [`Azure windows Web App`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_web_app#attributes-reference) **`hostname`** attribute

## Samples

You have the samples in [samples folder](../../samples/windowswebapp/). Simply run the triad terraform commands inside the sample folder:

```bash
terraform init
terraform plan
terraform apply
```
