locals {
  sharePluginsName = "${var.instanceName}-sonarqube-bundled-plugins"
  shareConfName = "${var.instanceName}-sonarqube-conf"
  shareDataName = "${var.instanceName}-sonarqube-data"
  shareExtensionsName = "${var.instanceName}-sonarqube-extensions"
  shareLogsName = "${var.instanceName}-sonarqube-logs"

  appName = "${var.instanceName}-sonarqube-web"
  databaseName = var.instanceName
  composeyaml = file("${path.module}/compose.yml")
}

resource "azurerm_storage_share" "sharePlugins" {  
  name = local.sharePluginsName
  storage_account_name = var.accountName
  quota = var.fileShareQuota
}

resource "azurerm_storage_share" "shareConf" {
  name = local.shareConfName
  storage_account_name = var.accountName
  quota = var.fileShareQuota
}

resource "azurerm_storage_share" "shareData" {
  name = local.shareDataName
  storage_account_name = var.accountName
  quota = var.fileShareQuota
}

resource "azurerm_storage_share" "shareExtensions" {
  name = local.shareExtensionsName
  storage_account_name = var.accountName
  quota = var.fileShareQuota
}

resource "azurerm_storage_share" "shareLogs" {
  name = local.shareLogsName
  storage_account_name = var.accountName
  quota = var.fileShareQuota
}

//this is the only manual step I have try to do it with the code below with no success
//you need to copy the profile.json to share "${var.instanceName}-sonarqube-conf"

# resource "null_resource" "uploadfile" {

#       provisioner "local-exec" {


#       command = <<-EOT
#       $storageAcct = Get-AzStorageAccount -ResourceGroupName "${var.resourceGroupName}" -Name "${var.accountName}"
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

  depends_on = [
    azurerm_storage_share.sharePlugins,
    azurerm_storage_share.shareConf,
    azurerm_storage_share.shareData,
    azurerm_storage_share.shareExtensions
  ]

  name = local.appName
  app_service_plan_id = var.appSrvPlanId
  resource_group_name = var.resourceGroupName
  location = var.location
  https_only = true
  client_affinity_enabled = true

  tags = var.tags

  site_config {
    http2_enabled = true
    always_on = true
    min_tls_version = "1.2"
    ftps_state = "FtpsOnly"
    linux_fx_version = "COMPOSE|${base64encode(local.composeyaml)}"
  }

  app_settings = {
    "SONARQUBE_JDBC_URL": "jdbc:sqlserver://${var.sqlServerName}.database.windows.net:1433;database=${local.databaseName};user=${var.sqlUserName}@${var.sqlServerName};password=${var.sqlUserPassword};encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;"
    "SONARQUBE_JDBC_USERNAME" = var.sqlUserName
    "SONARQUBE_JDBC_PASSWORD" = var.sqlUserPassword
    "SONAR_ES_BOOTSTRAP_CHECKS_DISABLE" = "true"
    "WEBSITES_PORT" = "80"
  }

  storage_account {
    type = "AzureFiles"
    name = "sonarqube-bundled-plugins" # match the name of the docker compose volume, the match is not needed but is in place to better identify the binding
    account_name = var.accountName
    share_name = azurerm_storage_share.sharePlugins.name
    access_key = var.accountAccessKey
    mount_path = "/opt/sonarqube/lib/bundled-plugins"
  }

  storage_account {
    type = "AzureFiles"
    name = "sonarqube-conf"
    account_name = var.accountName
    share_name = azurerm_storage_share.shareConf.name
    access_key = var.accountAccessKey
    mount_path = "/opt/sonarqube/conf"
  }

  storage_account {
    type = "AzureFiles"
    name = "sonarqube-data"
    account_name = var.accountName
    share_name = azurerm_storage_share.shareData.name
    access_key = var.accountAccessKey
    mount_path = "/opt/sonarqube/data"
  }

  storage_account {
    type = "AzureFiles"
    name = "sonarqube-extensions"
    account_name = var.accountName
    share_name = azurerm_storage_share.shareExtensions.name
    access_key = var.accountAccessKey
    mount_path = "/opt/sonarqube/extensions"
  }

  storage_account {
    type = "AzureFiles"
    name = "sonarqube-logs"
    account_name = var.accountName
    share_name = azurerm_storage_share.shareLogs.name
    access_key = var.accountAccessKey
    mount_path = "/opt/sonarqube/logs"
  }
}

resource "azurerm_sql_database" "db" {
  name = local.databaseName
  resource_group_name = var.resourceGroupName
  location = var.location
  server_name = var.sqlServerName
  collation = "SQL_Latin1_General_CP1_CS_AS"
  edition = "Standard"
  requested_service_objective_name = "S0"

  tags = var.tags
}