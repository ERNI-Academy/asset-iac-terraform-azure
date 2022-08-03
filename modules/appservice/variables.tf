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

variable "plan_id" {
  type        = string
  description = "The Id of the Azure Service Plan"
}

variable "environment" {
  type        = string
  description = "The environment"
}

variable "app_name" {
  type        = string
  description = "The Name of the Azure App Service"
}

variable "client_affinity_enabled" {
  type        = bool
  description = "Should the App Service send session affinity cookies, which route client requests in the same session to the same instance. Default false"
  default     = false
}

variable "websockets_enabled" {
  type        = bool
  description = "Should the WebSockets enabled. Default false"
  default     = false
}

variable "law_id" {
  type        = string
  description = "The Logs Analytics Workspace Id of the environment"
}

variable "app_settings_custom" {
  type        = map(any)
  description = "The custom App Settings for the app service."
  default     = {}
}

variable "tags" {
  type = map(any)
}
