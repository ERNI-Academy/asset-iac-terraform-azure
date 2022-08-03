// ------------------------------------------------------------------------------
// module configuration variables
// ------------------------------------------------------------------------------
variable "account_name" {
  type        = string
  description = "Specifies the name of the storage account"
}

variable "account_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
}

variable "account_kind" {
  type        = string
  description = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Changing this forces a new resource to be created. Defaults to StorageV2"
  default     = "StorageV2"
}

variable "account_access_tier" {
  type        = string
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot"
  default     = "Hot"
}

variable "account_replication_type" {
  type        = string
  description = "Defines the type of replication to use for this storage account. Valid options are LRS (Locally Redundant Storage), GRS (Geo Redundant Storage), ZRS (Zone Redundant Storage) and GZRS (Geo Zone Redundant Storage). Changing this forces a new resource to be created."
}

variable "min_tls_version" {
  type        = string
  default     = "TLS1_2"
  description = "The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts."
}

variable "identity_type" {
  type        = string
  description = "Specifies the type of Managed Service Identity that should be configured on this Kubernetes Cluster. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both)"
  default     = "SystemAssigned"
}

variable "identity_ids" {
  type        = list(string)
  description = "Specifies a list of User Assigned Managed Identity IDs to be assigned to this Kubernetes Cluster.\r\nThis is required when type is set to UserAssigned or SystemAssigned, UserAssigned"
  default     = null
}

variable "queue_loging_delete" {
  type        = bool
  description = "Indicates whether all delete requests should be logged. Changing this forces a new resource. Default false"
  default     = false
}

variable "queue_loging_read" {
  type        = bool
  description = "Indicates whether all read requests should be logged. Changing this forces a new resource. Default false"
  default     = false
}

variable "queue_loging_write" {
  type        = bool
  description = "Indicates whether all write requests should be logged. Changing this forces a new resource. Default false"
  default     = false
}

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

variable "function_name" {
  type        = string
  description = "The Name of the Azure Service Function"
}

variable "plan_id" {
  type        = string
  description = "The Id of the Azure Service Plan"
}

variable "law_id" {
  type        = string
  description = "The Logs Analytics Workspace Id of the environment"
}

variable "app_settings_custom" {
  type        = map(any)
  description = "The custom App Settings for the function app."
  default     = {}
}

variable "tags" {
  type = map(any)
}
