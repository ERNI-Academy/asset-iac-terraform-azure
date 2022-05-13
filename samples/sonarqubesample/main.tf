terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = ">= >= 3.5.0"
        }
    }
}

provider "azurerm" {
    features {}
}

module "sonarqube" {
    source = "../../modules/sonarqube"

    resource_group_name = "mysonarqube123"
    account_name = "mysonarqube123"
    sql_server_name = "mysonarqube122"
    app_service_plan_name = "mysonarqube123"
    sonarqube_instances = [ "sonarqube-for-organization-a", "sonarqube-for-organization-b" ]

    tags =  {
        MyTag = "MyTag value"
    }
}