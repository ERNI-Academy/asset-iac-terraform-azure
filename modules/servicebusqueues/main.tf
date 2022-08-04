// This module creates an Service Bus Queues
// Those resources are needed to be created previusly:
// 1- Resource Group -> to hold the resources
// 2- Service Bus -> the service bus namespace

resource "azurerm_servicebus_queue" "queue" {
  namespace_id        = var.service_bus_id
  enable_partitioning = var.enable_partitioning
  default_message_ttl = var.queue_ttl
  max_delivery_count  = var.max_delivery_count

  for_each = toset(var.queues)

  name = each.value
}
