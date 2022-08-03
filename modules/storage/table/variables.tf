// ------------------------------------------------------------------------------
// module configuration variables
// ------------------------------------------------------------------------------
variable "account_name" {
  type        = string
  default     = ""
  description = " Specifies the name of the storage account"
}

variable "account_id" {
  type        = string
  default     = ""
  description = "Specifies the id of the storage account"
}

variable "account_tier" {
  type        = string
  default     = ""
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
}

variable "account_kind" {
  type        = string
  default     = "StorageV2"
  description = " Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Changing this forces a new resource to be created. Defaults to StorageV2."
}

variable "account_replication_type" {
  type        = string
  default     = ""
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa."
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

variable "table_name" {
  type        = string
  description = "Specifies the name of the table"
}

variable "tags" {
  type = map(any)
}
