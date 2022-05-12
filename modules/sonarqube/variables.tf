variable "location" {
    type = string
    default = "West Europe"
    description = "The location"
}

variable "resource_group_name" {
    type = string
    description = "The name of the Resource Group"
}

variable "app_service_plan_name" {
    type = string
    description = "The name of the Azure Service Plan"
}

variable "app_service_plan_sku_tier" {
    type = string
    default = "Basic"
    description = "The sku of the Azure Service Plan. Default Basic"
}

variable "app_service_plan_sku_size" {
    type = string
    default = "B2"
    description = "The sku size of the Azure Service Plan. Default B2"
}

variable "account_name" {
    type = string
    description = "The sku size of the Azure Storage Account"
}

variable "sql_server_name" {
    type = string
    description = "The name of the Azure Sql Server"
}

variable "sonarqube_instances" {
  type = list(string)
  description = "The instances of sonarqube to be created"
} 

variable "tags" {
  type = map
}