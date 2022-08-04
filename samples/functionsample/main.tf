terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.5.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "MyRg"
  location = "West Europe"
  tags = {
    MyTag = "MyTag value"
  }
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "functionsamplelaw"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_app_service_plan" "plan" {
  name                = "functionsampleappplan"
  resource_group_name = var.resource_group_name
  location            = var.location
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }

  tags = var.tags
}

module "function" {
  source = "../../modules/function"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  function_name       = "myfnapp"
  environment         = "DEV"
  law_id              = azurerm_log_analytics_workspace.law.id
  plan_id             = azurerm_app_service_plan.plan.id
  tags = {
    MyTag = "MyTag value"
  }

  depends_on = [
    azurerm_resource_group.rg,
    azurerm_log_analytics_workspace.law,
    azurerm_app_service_plan.plan
  ]
}
