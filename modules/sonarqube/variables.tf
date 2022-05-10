variable "location" {
    type = string
    default = "West Europe"
    description = "The location"
}

variable "resourceGroupName" {
    type = string
    description = "The name of the Resource Group"
}

variable "appServicePlanName" {
    type = string
    description = "The name of the Azure Service Plan"
}

variable "appServicePlanSku" {
    type = string
    default = "Basic"
    description = "The sku of the Azure Service Plan. Default Basic"
}

variable "appServicePlanSkuSize" {
    type = string
    default = "B2"
    description = "The sku size of the Azure Service Plan. Default B2"
}

variable "accountName" {
    type = string
    description = "The sku size of the Azure Storage Account"
}

variable "sqlServerName" {
    type = string
    description = "The name of the Azure Sql Server"
}

variable "sonarqubeInstances" {
  type = list(string)
  description = "The instances of sonarqube to be created"
} 

variable "tags" {
  type = map
}