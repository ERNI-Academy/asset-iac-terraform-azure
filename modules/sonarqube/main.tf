/* This module creates the shared hosting infrastructure to hold many sonarqube instances

Resources created by this module:
1- Resource group
2- App Service Plan
3- Storage Account
4- Sql Server
5- Loop to create many instances of sonarqube and they will share the hosting layer
   e.g. every instance will have an AppService, an exclusive Database and an exclusive files 
*/

locals {
  sql_user_name = "__Sonarsql_ServerUser__"      # replace at build time using secrets
  sql_password = "__Sonarsql_ServerPassword__"  # replace at build time using secrets
}

resource "azurerm_resource_group" "rg" {
  name = var.resource_group_name
  location = var.location
  tags = var.tags
}

resource "azurerm_app_service_plan" "plan" {
  name = var.app_service_plan_name
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  kind = "Linux"
  reserved = true
  
  sku {
    tier = var.app_service_plan_sku_tier
    size = var.app_service_plan_sku_size
  }
  
  tags = var.tags

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_storage_account" "account" {
  name = var.account_name
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  account_tier = "Standard"
  account_kind = "StorageV2"
  account_replication_type = "LRS"
  access_tier = "Hot"
  min_tls_version = "TLS1_2"

  tags = var.tags

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_sql_server" "sql_server" {
  name = var.sql_server_name
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  version = "12.0"
  administrator_login = local.sql_user_name
  administrator_login_password = local.sql_password

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags

  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "sonarqube_instances" {
  source = "./sonarqubeinstance"

  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  account_name = azurerm_storage_account.account.name
  account_access_key = azurerm_storage_account.account.primary_access_key
  app_srv_plan_Id = azurerm_app_service_plan.plan.id
  sql_server_name = azurerm_sql_server.sql_server.name
  sql_user_name = local.sql_user_name
  sql_user_password = local.sql_password

  for_each = toset(var.sonarqube_instances)

  instance_name = each.value
  
  tags = var.tags

  depends_on = [
    azurerm_app_service_plan.plan,
    azurerm_storage_account.account,
    azurerm_sql_server.sql_server
  ]
}