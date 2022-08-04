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

module "appservice" {
  source = "../../modules/appservice"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  app_name            = "myapp"
  environment         = "DEV"
  plan_id             = "[id of your app service plan that you need to create first]"    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_plan
  law_id              = "[id of your analytics workspace that you need to create first]" # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace

  tags = {
    MyTag = "MyTag value"
  }

  depends_on = [
    azurerm_resource_group.rg
  ]
}
