variable "resourceGroupName" {
    type = string
    description = "The Resource Group name"
}

variable "serviceBusName" {
    type = string
    description = "The Service Bus Name"
}

variable "queues" {
  type = list(string)
}

variable "enablePartitioning" {
    type = bool
    description = "Boolean flag which controls whether to enable the queue to be partitioned across multiple message brokers. Changing this forces a new resource to be created. Defaults to false for Basic and Standard. For Premium, it MUST be set to true"
    default = false
}

variable "queueTtl" {
    type = string
    description = "The ISO 8601 timespan duration of TTL of messages sent to this queue if no TTL value is set on the message itself. Default 7 days"
    default = "P7D"
}

variable "maxDeliveryCount" {
    type = number
    description = "Integer value which controls when a message is automatically dead lettered. Defaults to 2"
    default = 2
}