variable "resourceGroupName" {
    type = string
    description = "The Resource Group name"
}

variable "serviceBusName" {
    type = string
    description = "The Service Bus Name"
}

variable "serviceBusTopicsSubscriptions" {
  type = list(object({
    topicName = string
    subscriptionName = string
  }))
}

variable "topicTtl" {
    type = string
    description = "The ISO 8601 timespan duration of TTL of messages sent to this topic if no TTL value is set on the message itself. Default 7 days"
    default = "P7D"
}

variable "subscriptionMaxDeliveryCount" {
    type = number
    description = "The maximum number of deliveries"
    default = 2
}

variable "subscriptionTtl" {
    type = string
    description = "The Default message timespan to live as an ISO 8601 duration. This is the duration after which the message expires, starting from when the message is sent to Service Bus. This is the default value used when TimeToLive is not set on a message itself"
    default = "P7D"
}

variable "subscriptionEnableDeadLetter" {
    type = bool
    description = "Boolean flag which controls whether the Subscription has dead letter support when a message expires. Default true"
    default = true
}

variable "subscriptionEnableBatchOperations" {
    type = bool
    description = "Boolean flag which controls whether the Subscription supports batched operations. Default true"
    default = true
}