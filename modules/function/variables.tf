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

variable "function_name" {
    type = string
    description = "The Name of the Azure Service Function"
}

variable "law_id" {
    type = string
    description = "The Logs Analytics Workspace Id of the environment"
}

variable "app_settings_custom" {
    type = map
    description = "The custom App Settings for the function app."
    default = {}
}

variable "tags" {
  type = map
}