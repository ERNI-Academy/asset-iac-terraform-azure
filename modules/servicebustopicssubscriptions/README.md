# Azure ServiceBus Subscriptions & Topics

A [Terraform](https://www.terraform.io) module for creating
[`Azure ServiceBus Subscription`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription) and [`Azure ServiceBus Topics`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_topic) resources.

- [Azure ServiceBus Subscriptions & Topics](#azure-servicebus-subscriptions--topics)
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

This module creates [`Azure ServiceBus Subscription`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription) and [`Azure ServiceBus Topics`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_topic) resources.

## Getting Started

Most basic usage creating a [`Azure ServiceBus Subscription`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription) and [`Azure ServiceBus Topics`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_topic) resource.

```terraform
module "servicebus_topics_subscriptions" {
    source = "../../modules/servicebustopicssubscriptions"

    service_bus_id = azurerm_servicebus_namespace.bus.id
    topics_subscriptions = [
        {
            topic_name = "topicA",
            subscription_name = "sub1"
        },
        {
            topic_name = "topicA",
            subscription_name = "sub2"
        },
        {
            topic_name = "topicB",
            subscription_name = "sub3"
        }
    ]

    depends_on = [
        azurerm_servicebus_namespace.bus
    ]
}
```

## Module Argument Reference

See [variables.tf](variables.tf)

## Samples

You have the samples in [samples folder](../../samples/servicebussample/)
