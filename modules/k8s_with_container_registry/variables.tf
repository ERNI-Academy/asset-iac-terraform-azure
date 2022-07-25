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

variable "container_name" {
    type = string
    description = "The Name of the Azure Container Registry Service"
}

variable "container_sku" {
    type = string
    description = "The Name of the Azure Container SKU. Possible values are Basic, Standard and Premium"
}

variable "public_network_access_enabled" {
    type = bool
    default = true
    description = "Whether public network access is allowed for the container registry. Possible values are false, true (default)"
}

variable "container_admin_enabled" {
    type = bool
    default = false
    description = "Specifies whether the admin user is enabled for the container registry. Possible values are true, false (default)"
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