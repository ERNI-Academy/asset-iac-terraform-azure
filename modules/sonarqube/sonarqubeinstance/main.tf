/* This module creates the resources for a Sonarqube instance

Resources created by this module:
1- Files shares in the Storage accounts.
2- App Service that host the docker compose fil
3- Sql Database

There is a manual step after the execution of this module, look at the TODO in this file

*/

locals {
  share_plugins_name = "${var.instance_name}-sonarqube-bundled-plugins"
  share_conf_name = "${var.instance_name}-sonarqube-conf"
  share_data_name = "${var.instance_name}-sonarqube-data"
  share_extensions_name = "${var.instance_name}-sonarqube-extensions"
  share_logs_name = "${var.instance_name}-sonarqube-logs"

  app_name = "${var.instance_name}-sonarqube-web"
  database_name = var.instance_name
  compose_yaml = file("${path.module}/compose.yml")
}

resource "azurerm_storage_share" "share_plugins" {  
  name = local.share_plugins_name
  storage_account_name = var.account_name
  quota = var.file_share_quota
}

resource "azurerm_storage_share" "share_conf" {
  name = local.share_conf_name
  storage_account_name = var.account_name
  quota = var.file_share_quota
}

resource "azurerm_storage_share" "share_data" {
  name = local.share_data_name
  storage_account_name = var.account_name
  quota = var.file_share_quota
}

resource "azurerm_storage_share" "share_extensions" {
  name = local.share_extensions_name
  storage_account_name = var.account_name
  quota = var.file_share_quota
}

resource "azurerm_storage_share" "share_logs" {
  name = local.share_logs_name
  storage_account_name = var.account_name
  quota = var.file_share_quota
}

//TODO: automate
//this is the only manual step I have try to automated with the code below with no success
//you need to copy the profile.json to share "${var.instance_name}-sonarqube-conf"

# resource "null_resource" "uploadfile" {

#       provisioner "local-exec" {


#       command = <<-EOT
#       $storageAcct = Get-AzStorageAccount -resource_group_name "${var.resource_group_name}" -Name "${var.account_name}"
#        Set-AzStorageFileContent `
#        -Context $storageAcct.Context `
#        -ShareName "${local.shareSeccompName}" `
#        -Source "[path in agent].profile.json" `
#        -Path "profile.json"

#       EOT

#       interpreter = ["PowerShell", "-Command"]
#       }

# }


resource "azurerm_app_service" "app" {
  name = local.app_name
  app_service_plan_id = var.app_srv_plan_Id
  resource_group_name = var.resource_group_name
  location = var.location
  https_only = true
  client_affinity_enabled = true

  site_config {
    http2_enabled = true
    always_on = true
    min_tls_version = "1.2"
    ftps_state = "FtpsOnly"
    linux_fx_version = "COMPOSE|${base64encode(local.compose_yaml)}"
  }

  app_settings = {
    "SONARQUBE_JDBC_URL": "jdbc:sqlserver://${var.sql_server_name}.database.windows.net:1433;database=${local.database_name};user=${var.sql_user_name}@${var.sql_server_name};password=${var.sql_user_password};encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;"
    "SONARQUBE_JDBC_USERNAME" = var.sql_user_name
    "SONARQUBE_JDBC_PASSWORD" = var.sql_user_password
    "SONAR_ES_BOOTSTRAP_CHECKS_DISABLE" = "true"
    "WEBSITES_PORT" = "80"
  }

  storage_account {
    type = "AzureFiles"
    name = "sonarqube-bundled-plugins" # match the name of the docker compose volume, the match is not needed but is in place to better identify the binding
    account_name = var.account_name
    share_name = azurerm_storage_share.share_plugins.name
    access_key = var.account_access_key
    mount_path = "/opt/sonarqube/lib/bundled-plugins"
  }

  storage_account {
    type = "AzureFiles"
    name = "sonarqube-conf"
    account_name = var.account_name
    share_name = azurerm_storage_share.share_conf.name
    access_key = var.account_access_key
    mount_path = "/opt/sonarqube/conf"
  }

  storage_account {
    type = "AzureFiles"
    name = "sonarqube-data"
    account_name = var.account_name
    share_name = azurerm_storage_share.share_data.name
    access_key = var.account_access_key
    mount_path = "/opt/sonarqube/data"
  }

  storage_account {
    type = "AzureFiles"
    name = "sonarqube-extensions"
    account_name = var.account_name
    share_name = azurerm_storage_share.share_extensions.name
    access_key = var.account_access_key
    mount_path = "/opt/sonarqube/extensions"
  }

  storage_account {
    type = "AzureFiles"
    name = "sonarqube-logs"
    account_name = var.account_name
    share_name = azurerm_storage_share.share_logs.name
    access_key = var.account_access_key
    mount_path = "/opt/sonarqube/logs"
  }

  tags = var.tags

  depends_on = [
    azurerm_storage_share.share_plugins,
    azurerm_storage_share.share_conf,
    azurerm_storage_share.share_data,
    azurerm_storage_share.share_extensions
  ]
}

resource "azurerm_sql_database" "db" {
  name = local.database_name
  resource_group_name = var.resource_group_name
  location = var.location
  server_name = var.sql_server_name
  collation = "SQL_Latin1_General_CP1_CS_AS"
  edition = "Standard"
  requested_service_objective_name = "S0"

  tags = var.tags
}