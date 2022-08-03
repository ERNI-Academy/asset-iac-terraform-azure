# Azure ServiceBus queues

[![License](https://img.shields.io/badge/License-Apache%202.0-brightgreen.svg)](https://opensource.org/licenses/Apache-2.0)

A [Terraform](https://www.terraform.io) 0.12 module for creating
[`Azure ServiceBus Queue`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_queue) resources.

- [Azure ServiceBus queues](#azure-servicebus-queues)
  - [Prerequisits](#prerequisits)
  - [Module Features](#module-features)
  - [Getting Started](#getting-started)
  - [Module Argument Reference](#module-argument-reference)
  - [Samples](#samples)

## Prerequisits

To use this module you need the following resources:

- [`Azure Resource Group`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)
- [`Azure ServiceBus Namespace`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace)

## Module Features

This module creates [`Azure ServiceBus Queue`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_queue) resources.

## Getting Started

Most basic usage creating a [`Azure ServiceBus Queue`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_queue) resource.

```terraform
module "servicebus_queues" {
    source = "."
    
    service_bus_id = azurerm_servicebus_namespace.bus.id
    queues = ["queueA", "queueB"]

    depends_on = [
        azurerm_servicebus_namespace.bus
    ]
}
```

## Module Argument Reference

See [variables.tf](variables.tf)

## Samples

You have the samples in [samples folder](../../samples/servicebussample/)
