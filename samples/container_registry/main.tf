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
    environment = "Demo"
  }
}

module "container" {
  source                  = "../../modules/containerregistryservice"
  environment             = "development"
  resource_group_name     = azurerm_resource_group.rg.name
  location                = azurerm_resource_group.rg.location
  container_name          = "k8sSample"
  container_sku           = "Basic"
  container_admin_enabled = true

  tags = {
    environment = "Demo"
  }
}
