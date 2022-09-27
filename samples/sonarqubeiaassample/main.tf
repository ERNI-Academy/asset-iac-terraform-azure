terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.5.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "sonarqubeiaas" {
  source                 = "../../modules/sonarqubeiaas"
  location               = "westeurope"
  admin_username         = "ubuntu"
  domain_name            = "mysqtwitch"
  resource_group_name    = "mysq123"
  virtual_network_name   = "mysqVnet"
  subnet_name            = "mysqSubnet"
  public_ip_name         = "mysqIP"
  nsg_name               = "mysqNSG"
  network_interface_name = "mysqNIC"
  ip_config_name         = "sqNicConfig"
  linux_vm_name          = "mysqVM"
  comp_name              = "mysqVM"
  os_disk_name           = "mysqDisk"

  tags = {
    MyTag = "MyTag value"
  }
}
