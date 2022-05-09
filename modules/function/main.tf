// This module creates an Application Insights + Storage Account + App Service Plan Dynamic + Function
// Those resources are needed to be created previusly:
// 1- Resource Group -> to hold the resources
// 2- Analytics Workspace -> the analytics workspace for the application insights

locals {
 accountName = "${lower(var.functionName)}${var.environment}"
 planName = "${var.functionName}-${var.environment}"
 insightsName = "${var.functionName}-${var.environment}"
 functionName = "${var.functionName}-${var.environment}"
 insightsHealthPingName = "${var.functionName}-${var.environment}"
 environment = upper(var.environment)
 
 appSettings = {
    "WEBSITE_RUN_FROM_PACKAGE" = 1
    "WEBSITE_SWAP_WARMUP_PING_PATH" = "api/health"
    "FUNCTIONS_EXTENSION_VERSION" = "~4"
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.insights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.insights.connection_string
    "ASPNETCORE_ENVIRONMENT" = local.environment
  }
}

resource "azurerm_storage_account" "account" {
  name = local.accountName
  resource_group_name = var.resourceGroupName
  location = var.location
  account_tier = "Standard"
  account_kind = "StorageV2"
  account_replication_type = "LRS"
  access_tier = "Hot"
  min_tls_version = "TLS1_2"
  tags = var.tags
}

resource "azurerm_app_service_plan" "plan" {
  name = local.planName
  resource_group_name = var.resourceGroupName
  location = var.location
  kind = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }

  tags = var.tags
}

resource "azurerm_application_insights" "insights" {
  name = local.insightsName
  resource_group_name = var.resourceGroupName
  location = var.location
  application_type = "web"
  workspace_id = var.lawId
  public_network_access_enabled = false
  internet_query_enabled = false
  tags = var.tags
}

resource "azurerm_function_app" "fnapp" {
  depends_on = [
    azurerm_storage_account.account,
    azurerm_app_service_plan.plan,
    azurerm_application_insights.insights
  ]

  name = local.functionName
  resource_group_name = var.resourceGroupName
  location = var.location

  app_service_plan_id = azurerm_app_service_plan.plan.id
  storage_account_name = local.accountName
  storage_account_access_key = module.account.primaryAccessKey
  tags = var.tags
  https_only = true
  version = "~4"

  site_config {
    health_check_path = "/health"
    http2_enabled = true
    ftps_state = "FtpsOnly"
    dotnet_framework_version = "v6.0"
  }

  app_settings = merge(local.appSettings, var.appSettingsCustom)
}

resource "random_uuid" "webTestId" {}
resource "random_uuid" "webTestRequestId" {}

resource "azurerm_application_insights_web_test" "insightsHealthPing" {
  name = local.insightsHealthPingName
  location = azurerm_function_app.fnapp.location
  resource_group_name = var.resourceGroupName
  application_insights_id = azurerm_application_insights.insights.id
  kind = "ping"
  frequency = 300 //5min
  timeout = 60
  enabled = true
  retry_enabled = true
  
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  
  geo_locations = ["us-tx-sn1-azr", "us-il-ch1-azr", "emea-gb-db3-azr", "emea-nl-ams-azr", "apac-sg-sin-azr"] //South Central US, North Central US, North Europe, West Europe, Southeast Asia

  configuration = <<XML
<WebTest Name="HealthPing" Id="${random_uuid.webTestId.result}" Enabled="True" CssProjectStructure="" CssIteration="" Timeout="0" WorkItemIds="" xmlns="http://microsoft.com/schemas/VisualStudio/TeamTest/2010" Description="" CredentialUserName="" CredentialPassword="" PreAuthenticate="True" Proxy="default" StopOnError="False" RecordedResultFile="" ResultsLocale="">
  <Items>
    <Request Method="GET" Guid="${random_uuid.webTestRequestId.result}" Version="1.1" Url="https://${azurerm_function_app.fnapp.default_hostname}/api/health" ThinkTime="0" Timeout="300" ParseDependentRequests="True" FollowRedirects="True" RecordResult="True" Cache="False" ResponseTimeGoal="0" Encoding="utf-8" ExpectedHttpStatusCode="200" ExpectedResponseUrl="" ReportingName="" IgnoreHttpStatusCode="False" />
  </Items>
</WebTest>
XML
}
