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
  source = "../../modules/linuxwebapp"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  app_name            = "3253245linux" //Change me!
  plan_name           = "myplan"
  environment         = "DEV"
  workspace_name      = "myworkspace"

  tags = {
    MyTag = "MyTag value"
  }

  depends_on = [
    azurerm_resource_group.rg
  ]
}
