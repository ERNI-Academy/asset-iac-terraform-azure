// This module creates an Service Bus Queues
// Those resources are needed to be created previusly:
// 1- Resource Group -> to hold the resources
// 2- Service Bus -> the service bus namespace

resource "azurerm_servicebus_queue" "queue" {
  resource_group_name = var.resourceGroupName
  namespace_name = var.serviceBusName
  enable_partitioning = var.enablePartitioning
  default_message_ttl = var.queueTtl
  max_delivery_count = var.maxDeliveryCount

  for_each = toset(var.queues)

  name = each.value
}