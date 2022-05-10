variable "resourceGroupName" {
    type = string
    description = "The Resource Group name"
}

variable "location" {
    type = string
    description = "The location"
}

variable "planId" {
    type = string
    description = "The Id of the Azure Service Plan"
}

variable "environment" {
    type = string
    description = "The environment"
}

variable "appName" {
    type = string
    description = "The Name of the Azure App Service"
}

variable "arrAffinityEnabled" {
    type = bool
    description = "Should the App Service send session affinity cookies, which route client requests in the same session to the same instance. Default false"
    default = false
}

variable "websocketsEnabled" {
    type = bool
    description = "Should the WebSockets enabled. Default false"
    default = false
}

variable "lawId" {
    type = string
    description = "The Logs Analytics Workspace Id of the environment"
}

variable "appSettingsCustom" {
    type = map
    description = "The custom App Settings for the app service."
    default = {}
}

variable "tags" {
  type = map
}