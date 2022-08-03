// ------------------------------------------------------------------------------
// module configuration variables
// ------------------------------------------------------------------------------
variable "location" {
  type        = string
  default     = "West Europe"
  description = "The location"
}

variable "resource_group_name" {
  type        = string
  description = "The ResourceGroup name"
}

variable "instance_name" {
  type        = string
  description = "The Sonarqube instance name used as name of DB and suffix for app service and file share"
}

variable "account_name" {
  type        = string
  description = "The Storage Account name"
}

variable "account_access_key" {
  type        = string
  description = "The Storage Account access key"
}

variable "file_share_quota" {
  type        = number
  description = "The File Share Quota for sonarqube volumes"
  default     = 50
}

variable "app_srv_plan_Id" {
  type        = string
  description = "The App Service Plan id"
}

variable "sql_server_name" {
  type        = string
  description = "The SQL Server name"
}

variable "sql_user_name" {
  type        = string
  description = "The SQL Server user name"
}

variable "sql_user_password" {
  type        = string
  description = "The SQL Server user password"
}

variable "tags" {
  type        = map(any)
  description = "The tags"
}
