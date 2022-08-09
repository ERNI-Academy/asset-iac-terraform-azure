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
  name     = "k8sSample"
  location = "West Europe"

  tags = {
    environment = "Demo"
  }
}

module "aks" {
  source                         = "../../modules/aks"
  environment                    = "development"
  resource_group_name            = azurerm_resource_group.rg.name
  location                       = azurerm_resource_group.rg.location
  k8s_name                       = "k8sSample"
  default_node_pool_name         = "default"
  default_node_pool_node_count   = 3
  default_node_pool_vm_size      = "standard_d2_v2"
  default_node_pool_disk_size_gb = 300
  automatic_channel_upgrade      = "rapid"
  identity_type                  = "SystemAssigned"
  tags = {
    environment = "Demo"
  }
}
