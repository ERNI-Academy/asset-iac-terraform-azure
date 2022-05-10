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
  sqlUserName = "__SonarSqlServerUser__"      # replace at build time using secrets
  sqlPassword = "__SonarSqlServerPassword__"  # replace at build time using secrets
}

resource "azurerm_resource_group" "rgSonarqube" {
  name = var.resourceGroupName
  location = var.location
  tags = var.tags
}

resource "azurerm_app_service_plan" "plan" {
  name = var.appServicePlanName
  resourceGroupName = azurerm_resource_group.rgSonarqube.name
  location = azurerm_resource_group.rgSonarqube.location

  kind = "Linux"
  reserved = true

  sku {
    tier = var.skuTier
    size = var.skuSize
  }
  
  tags = var.tags
}

resource "azurerm_storage_account" "account" {
  depends_on = [
    azurerm_resource_group.rgSonarqube
  ]

  name = var.accountName
  resourceGroupName = azurerm_resource_group.rgSonarqube.name
  location = azurerm_resource_group.rgSonarqube.location
  account_tier = "Standard"
  account_kind = "StorageV2"
  account_replication_type = "LRS"
  access_tier = "Hot"
  min_tls_version = "TLS1_2"
  tags = var.tags
}

resource "azurerm_sql_server" "sqlServer" {
  depends_on = [
    azurerm_resource_group.rgSonarqube
  ]

  name = local.sqlServerName
  resource_group_name = azurerm_resource_group.rgSonarqube.name
  location = azurerm_resource_group.rgSonarqube.location
  version = "12.0"
  administrator_login = local.sqlUserName
  administrator_login_password = local.sqlPassword
  tags = var.tags
}

module "sonarqubeInstance" {
  source = "./sonarqubeinstance"

  depends_on = [
    azurerm_app_service_plan.appSrvPlan,
    azurerm_storage_account.storageAccount,
    azurerm_sql_server.sqlServer
  ]

  for_each = toset(var.sonarqubeInstances)
 
  resourceGroupName = azurerm_resource_group.rgSonarqube.name
  location = azurerm_resource_group.rgSonarqube.location
  accountName = local.accountName
  accountAccessKey = module.storageAccount.primaryAccessKey
  appSrvPlanId = module.appSrvPlan.id
  sqlServerName = local.sqlServerName
  sqlUserName = local.sqlUserName
  sqlUserPassword = local.sqlPassword
  instanceName = each.value
  tags = var.tags
}