variable "resourceGroupName" {
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

variable "functionName" {
    type = string
    description = "The Name of the Azure Service Function"
}

variable "lawId" {
    type = string
    description = "The Logs Analytics Workspace Id of the environment"
}

variable "appSettingsCustom" {
    type = map
    description = "The custom App Settings for the function app."
    default = {}
}

variable "tags" {
  type = map
}