variable "resource_group_name" {
    type = string
    description = "The Resource Group name"
}

variable "location" {
    type = string
    description = "The location"
}

variable "environment" {
    type = string
    description = "The environment"
}

variable "k8s_name" {
    type = string
    description = "The Name of the Azure k8s Service"
}

variable "default_node_pool_name" {
    type = string
    description = "The Name of the default node pool"
}

variable "default_node_pool_node_count" {
    type = number
    description = "The number of nodes on the default node pool"
}

variable "default_node_pool_vm_size" {
    type = string
    description = "The size of the vm's in the default node pool"
}

variable "default_node_pool_disk_size_gb" {
    type = number
    description = "The size in gb of the disk in the default node pool"
}

variable "tags" {
  type = map
}