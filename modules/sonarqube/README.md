# SonarQube

[![License](https://img.shields.io/badge/License-Apache%202.0-brightgreen.svg)](https://opensource.org/licenses/Apache-2.0)

A [Terraform](https://www.terraform.io) 0.12 module for creating sonarqube with its needed infrastructure.

- [SonarQube](#sonarqube)
  - [Module Features](#module-features)
  - [Getting Started](#getting-started)
  - [Module Argument Reference](#module-argument-reference)
  - [Samples](#samples)

## Module Features

This module creates a sonarqube with the following infrastructure ready to work:

- [`Azure Resource Group`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)
- [`Azure App Service Plan`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_plan)
- [`Azure Storage Account`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)
- [`Azure SQL Server`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sql_server)
- [`File Share within Azure Storage`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share)
- [`Azure App Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service)

## Getting Started

```terraform
module "sonarqube" {
    source = "../../modules/sonarqube"

    resource_group_name = "mysonarqube123"
    account_name = "mysonarqube123"
    sql_server_name = "mysonarqube122"
    app_service_plan_name = "mysonarqube123"
    sonarqube_instances = [ "sonarqube-for-organization-a", "sonarqube-for-organization-b" ]

    tags =  {
        MyTag = "MyTag value"
    }
}
```

## Module Argument Reference

See [variables.tf](variables.tf)

## Samples

You have the samples in [samples folder](../../samples/sonarqubesample/)
