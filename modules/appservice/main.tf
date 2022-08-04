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

resource "azurerm_application_insights" "insights" {
  name                   = local.insights_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  application_type       = "web"
  workspace_id           = var.law_id
  internet_query_enabled = false

  tags = var.tags
}

resource "azurerm_app_service" "app" {
  name                    = local.app_name
  app_service_plan_id     = var.plan_id
  resource_group_name     = var.resource_group_name
  location                = var.location
  https_only              = true
  client_affinity_enabled = var.client_affinity_enabled

  site_config {
    health_check_path        = "/health"
    http2_enabled            = true
    always_on                = true
    dotnet_framework_version = "v6.0"
    min_tls_version          = "1.2"
    websockets_enabled       = var.websockets_enabled
    ftps_state               = "FtpsOnly"
    scm_type                 = "VSTSRM"
  }

  app_settings = merge(local.app_settings, var.app_settings_custom)

  tags = var.tags

  depends_on = [
    azurerm_application_insights.insights
  ]
}
