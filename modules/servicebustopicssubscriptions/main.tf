// This module creates an Service Bus Topics + Service Bus Subscriptions
// Those resources are needed to be created previusly:
// 1- Resource Group -> to hold the resources
// 2- Service Bus -> the service bus namespace

locals {
 topics = toset(distinct([
    for x in var.topics_subscriptions : x.topic_name
 ]))
}


resource "azurerm_servicebus_topic" "topics" {  
  namespace_id = var.service_bus_id
  default_message_ttl = var.topic_ttl

  for_each = local.topics

  name = each.value
}

resource "azurerm_servicebus_subscription" "subscriptions" {
  max_delivery_count = var.subscription_max_delivery_count
  default_message_ttl = var.subscription_ttl
  dead_lettering_on_message_expiration = var.subscription_enable_dead_letter
  enable_batched_operations = var.subscription_enable_batch_operations

  count = length(var.topics_subscriptions)

  name = var.topics_subscriptions[count.index].subscription_name
  topic_id = azurerm_servicebus_topic.topics[var.topics_subscriptions[count.index].topic_name].id

  depends_on = [
    azurerm_servicebus_topic.topics
  ]
}

