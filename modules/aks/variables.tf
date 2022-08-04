// ------------------------------------------------------------------------------
// module configuration variables
// ------------------------------------------------------------------------------
variable "resource_group_name" {
  type        = string
  description = "The Resource Group name"
}

variable "location" {
  type        = string
  description = "The location"
}

variable "environment" {
  type        = string
  description = "The environment"
}

variable "k8s_name" {
  type        = string
  description = "The Name of the Azure k8s Service"
}

variable "default_node_pool_name" {
  type        = string
  description = "The Name of the default node pool"
}

variable "default_node_pool_node_count" {
  type        = number
  description = "The number of nodes on the default node pool"
}

variable "default_node_pool_vm_size" {
  type        = string
  description = "The size of the vm's in the default node pool"
}

variable "default_node_pool_disk_size_gb" {
  type        = number
  description = "The size in gb of the disk in the default node pool"
}

variable "automatic_channel_upgrade" {
  type        = string
  description = "The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, node-image and stable. Omitting this field sets this value to none"
  default     = "none"
}

variable "identity_type" {
  type        = string
  description = " Specifies the type of Managed Service Identity that should be configured on this Kubernetes Cluster. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both)"
  default     = "SystemAssigned"
}

variable "identity_ids" {
  type        = list(string)
  description = "Specifies a list of User Assigned Managed Identity IDs to be assigned to this Kubernetes Cluster.\r\nThis is required when type is set to UserAssigned or SystemAssigned, UserAssigned"
  default     = null
}

variable "tags" {
  type = map(any)
}
