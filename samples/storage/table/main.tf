terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.13.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "StorageSample"
  location = "West Europe"

  tags = {
    environment = "Demo"
  }
}

module "table" {
  source                   = "../../../modules/storage/table"
  account_name             = "accountsample"
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  environment              = "development"
  table_name               = "table"
  tags = {
    environment = "Demo"
  }
}
