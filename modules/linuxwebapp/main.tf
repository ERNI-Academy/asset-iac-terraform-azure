// This module creates an Application Insights + App Service
// Those resources are needed to be created previusly:
// 1- Resource Group -> to hold the resources
// 2- App Service Plan -> to host the app service
// 3- Analytics Workspace -> the analytics workspace for the application insights

locals {
  insights_name = "${var.app_name}-${var.environment}"
  app_name      = "${var.app_name}-${var.environment}"
  environment   = upper(var.environment)

  app_settings = {
    "WEBSITE_HEALTHCHECK_MAXPINGFAILURES" : 5
    "WEBSITE_RUN_FROM_PACKAGE"                   = "1"
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~2"
    "XDT_MicrosoftApplicationInsights_Mode"      = "default"
    "APPINSIGHTS_INSTRUMENTATIONKEY"             = azurerm_application_insights.insights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING"      = azurerm_application_insights.insights.connection_string
    "ASPNETCORE_ENVIRONMENT"                     = local.environment
  }
}

resource "azurerm_log_analytics_workspace" "workspace" {
  name                = var.workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_application_insights" "insights" {
  name                = local.insights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  workspace_id        = azurerm_log_analytics_workspace.workspace.id
  application_type    = "web"

  tags = var.tags
}

resource "azurerm_service_plan" "plan" {
  name                = var.plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.app_service_plan_os_type
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "app" {
  name                = local.app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    health_check_path        = "/health"
    http2_enabled            = true
    always_on                = true
    minimum_tls_version      = "1.2"
    websockets_enabled       = var.websockets_enabled
    ftps_state               = "FtpsOnly"
    application_stack {
      dotnet_version         = "6.0"
    }
  }

  app_settings = merge(local.app_settings, var.app_settings_custom)

  tags = var.tags
}