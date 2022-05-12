terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = ">= 3.5.0"
        }
    }
}

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "rg" {
    name = "MyRg"
    location = "West Europe"
    tags =  {
        MyTag = "MyTag value"
    }
}

resource "azurerm_servicebus_namespace" "bus" {
  name = "myservicebus"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku = "Standard"

  tags = {
     MyTag = "MyTag value"
  }

  depends_on = [
    azurerm_resource_group.rg
  ]
}

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

module "servicebus_queues" {
    source = "../../modules/servicebusqueues"
    
    service_bus_id = azurerm_servicebus_namespace.bus.id
    queues = ["queueA", "queueB"]

    depends_on = [
        azurerm_servicebus_namespace.bus
    ]
}