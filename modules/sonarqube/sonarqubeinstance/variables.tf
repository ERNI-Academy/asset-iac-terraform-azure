variable "location" {
    type = string
    default = "West Europe"
    description = "The location"
}

variable "resourceGroupName" {
    type = string
    description = "The ResourceGroup name"
}

variable "instanceName" {
    type = string
    description = "The Sonarqube instance name used as name of DB and suffix for app service and file share"
}

variable "accountName" {
    type = string
    description = "The Storage Account name"
}

variable "accountAccessKey" {
    type = string
    description = "The Storage Account access key"
}

variable "fileShareQuota" {
    type = number
    description = "The File Share Quota for sonarqube volumes"
    default = 50
}

variable "appSrvPlanId" {
    type = string
    description = "The App Service Plan id"
}

variable "sqlServerName" {
    type = string
    description = "The SQL Server name"
}

variable "sqlUserName" {
    type = string
    description = "The SQL Server user name"
}

variable "sqlUserPassword" {
    type = string
    description = "The SQL Server user password"
}

variable "tags" {
    type = map
    description = "The tags"
}