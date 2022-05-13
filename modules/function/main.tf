// This module creates an Application Insights + Storage Account + App Service Plan Dynamic + Function
// Those resources are needed to be created previusly:
// 1- Resource Group -> to hold the resources
// 2- Analytics Workspace -> the analytics workspace for the application insights

locals {
 account_name = "${lower(var.function_name)}${var.environment}"
 plan_name = "${var.function_name}-${var.environment}"
 insights_name = "${var.function_name}-${var.environment}"
 function_name = "${var.function_name}-${var.environment}"
 insights_health_ping_name = "${var.function_name}-${var.environment}"
 environment = upper(var.environment)
 
 app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = 1
    "WEBSITE_SWAP_WARMUP_PING_PATH" = "api/health"
    "FUNCTIONS_EXTENSION_VERSION" = "~4"
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.insights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.insights.connection_string
    "ASPNETCORE_ENVIRONMENT" = local.environment
  }
}

resource "azurerm_storage_account" "account" {
  name = local.account_name
  resource_group_name = var.resource_group_name
  location = var.location
  account_tier = "Standard"
  account_kind = "StorageV2"
  account_replication_type = "LRS"
  access_tier = "Hot"
  min_tls_version = "TLS1_2"

  tags = var.tags
}

resource "azurerm_app_service_plan" "plan" {
  name = local.plan_name
  resource_group_name = var.resource_group_name
  location = var.location
  kind = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }

  tags = var.tags
}

resource "azurerm_application_insights" "insights" {
  name = local.insights_name
  resource_group_name = var.resource_group_name
  location = var.location
  application_type = "web"
  workspace_id = var.law_id
  internet_query_enabled = false

  tags = var.tags
}

resource "azurerm_function_app" "fnapp" {
  name = local.function_name
  resource_group_name = var.resource_group_name
  location = var.location
  app_service_plan_id = azurerm_app_service_plan.plan.id
  storage_account_name = azurerm_storage_account.account.name
  storage_account_access_key = azurerm_storage_account.account.primary_access_key
  https_only = true
  version = "~4"

  site_config {
    health_check_path = "/health"
    http2_enabled = true
    ftps_state = "FtpsOnly"
    dotnet_framework_version = "v6.0"
  }

  app_settings = merge(local.app_settings, var.app_settings_custom)

  tags = var.tags

  depends_on = [
    azurerm_storage_account.account,
    azurerm_app_service_plan.plan,
    azurerm_application_insights.insights
  ]
}

resource "random_uuid" "webTestId" {}
resource "random_uuid" "webTestRequestId" {}

resource "azurerm_application_insights_web_test" "insightsHealthPing" {
  name = local.insights_health_ping_name
  location = azurerm_function_app.fnapp.location
  resource_group_name = var.resource_group_name
  application_insights_id = azurerm_application_insights.insights.id
  kind = "ping"
  frequency = 300 //5min
  timeout = 60
  enabled = true
  retry_enabled = true
  
  geo_locations = ["us-tx-sn1-azr", "us-il-ch1-azr", "emea-gb-db3-azr", "emea-nl-ams-azr", "apac-sg-sin-azr"] //South Central US, North Central US, North Europe, West Europe, Southeast Asia

  configuration = <<XML
<WebTest Name="HealthPing" Id="${random_uuid.webTestId.result}" Enabled="True" CssProjectStructure="" CssIteration="" Timeout="0" WorkItemIds="" xmlns="http://microsoft.com/schemas/VisualStudio/TeamTest/2010" Description="" CredentialUserName="" CredentialPassword="" PreAuthenticate="True" Proxy="default" StopOnError="False" RecordedResultFile="" ResultsLocale="">
  <Items>
    <Request Method="GET" Guid="${random_uuid.webTestRequestId.result}" Version="1.1" Url="https://${azurerm_function_app.fnapp.default_hostname}/api/health" ThinkTime="0" Timeout="300" ParseDependentRequests="True" FollowRedirects="True" RecordResult="True" Cache="False" ResponseTimeGoal="0" Encoding="utf-8" ExpectedHttpStatusCode="200" ExpectedResponseUrl="" ReportingName="" IgnoreHttpStatusCode="False" />
  </Items>
</WebTest>
XML

  lifecycle {
      ignore_changes = [
        tags
      ]
    }
}
