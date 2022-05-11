// This module creates an Service Bus Topics + Service Bus Subscriptions
// Those resources are needed to be created previusly:
// 1- Resource Group -> to hold the resources
// 2- Service Bus -> the service bus namespace

locals {
 serviceBusTopics = toset(distinct([
    for x in var.topicsSubscriptions : x.topicName
 ]))
}


resource "azurerm_servicebus_topic" "topics" {  
  resource_group_name = var.resourceGroupName
  namespace_name = var.serviceBusName
  default_message_ttl = var.topicTtl

  for_each = local.serviceBusTopics

  name = each.value
}

resource "azurerm_servicebus_subscription" "subscriptions" {
  depends_on = [
    azurerm_servicebus_topic.topics
  ]

  resource_group_name = var.resourceGroupName
  namespace_name = var.serviceBusName
  max_delivery_count = var.subscriptionMaxDeliveryCount
  default_message_ttl = var.subscriptionTtl
  dead_lettering_on_message_expiration = var.subscriptionEnableDeadLetter
  enable_batched_operations = var.subscriptionEnableBatchOperations

  count = length(var.topicsSubscriptions)

  name = var.topicsSubscriptions[count.index].subscriptionName
  topic_name = var.topicsSubscriptions[count.index].topicName
}

