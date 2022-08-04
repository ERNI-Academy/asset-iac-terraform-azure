// ------------------------------------------------------------------------------
// module configuration variables
// ------------------------------------------------------------------------------
variable "service_bus_id" {
  type        = string
  description = "The Service Bus Id"
}

variable "topics_subscriptions" {
  type = list(object({
    topic_name        = string
    subscription_name = string
  }))
}

variable "topic_ttl" {
  type        = string
  description = "The ISO 8601 timespan duration of TTL of messages sent to this topic if no TTL value is set on the message itself. Default 7 days"
  default     = "P7D"
}

variable "subscription_max_delivery_count" {
  type        = number
  description = "The maximum number of deliveries"
  default     = 2
}

variable "subscription_ttl" {
  type        = string
  description = "The Default message timespan to live as an ISO 8601 duration. This is the duration after which the message expires, starting from when the message is sent to Service Bus. This is the default value used when TimeToLive is not set on a message itself"
  default     = "P7D"
}

variable "subscription_enable_dead_letter" {
  type        = bool
  description = "Boolean flag which controls whether the Subscription has dead letter support when a message expires. Default true"
  default     = true
}

variable "subscription_enable_batch_operations" {
  type        = bool
  description = "Boolean flag which controls whether the Subscription supports batched operations. Default true"
  default     = true
}
