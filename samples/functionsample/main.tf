terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = ">= 3.5.0"
        }
    }
}

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "rg" {
    name = "MyRg"
    location = "West Europe"
    tags =  {
        MyTag = "MyTag value"
    }
}

module "function" {
    source = "../../modules/function"

    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    function_name = "myfnapp"
    environment = "DEV"
    law_id = "[id of your analytics workspace that you need to create first]"

    tags =  {
        MyTag = "MyTag value"
    }

    depends_on = [
        azurerm_resource_group.rg
    ]
} 