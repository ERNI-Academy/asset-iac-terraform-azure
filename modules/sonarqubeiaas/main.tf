/* This module creates the shared hosting infrastructure to hold a sonarqube instance

Resources created by this module:
1- Resource group
2- Virtual network
3- Subnet
4- Public IP
5- Network Security Group
6- Network Interface
7- Network Interface Security group
8- Storage Account
9- Virtual Machine (IaaS)

Improvements: User/Pass hardcoded, ports open, vulnerability checks...

*/

#Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

#Create Virtual Network
resource "azurerm_virtual_network" "myvnet" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = var.tags
}
#Create Subnet
resource "azurerm_subnet" "mysubnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

#Create Public IP
resource "azurerm_public_ip" "myip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  domain_name_label   = var.domain_name

  tags = var.tags
}
#Create Network Security Groups
resource "azurerm_network_security_group" "mynsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "allow-ssh"
    description                = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "allow-http"
    description                = "allow-http"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "allow-https"
    description                = "allow-https"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}
#Create NIC
resource "azurerm_network_interface" "mynic" {
  name                = var.network_interface_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = var.ip_config_name
    subnet_id                     = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.myip.id
  }

  tags = var.tags
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.mynic.id
  network_security_group_id = azurerm_network_security_group.mynsg.id
}

# Generate random names for the VM's storage account for diagnostics
resource "random_id" "randomId" {
  keepers = {

    resource_group = azurerm_resource_group.rg.name
  }

  byte_length = 8
}
# Provision storage account for VM diagnostics 
resource "azurerm_storage_account" "myvmstorage" {
  name                     = "diag${random_id.randomId.hex}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_replication_type = "LRS"
  account_tier             = "Standard"

  tags = var.tags
}

# Provision SSH Key
resource "tls_private_key" "myssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

data "template_file" "linux-vm-cloud-init" {
  template = file("${path.module}/scripts/sonar.sh")
}
# Provision Linux VM 
resource "azurerm_linux_virtual_machine" "myvm" {
  name                            = var.linux_vm_name
  location                        = var.location
  resource_group_name             = azurerm_resource_group.rg.name
  network_interface_ids           = [azurerm_network_interface.mynic.id]
  size                            = "Standard_B2s"
  computer_name                   = var.comp_name
  admin_username                  = var.admin_username
  custom_data                     = base64encode(data.template_file.linux-vm-cloud-init.rendered)
  disable_password_authentication = true
  os_disk {
    name                 = var.os_disk_name
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.myssh.public_key_openssh
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.myvmstorage.primary_blob_endpoint
  }

  tags = var.tags
}
resource "local_file" "mykey" {
  filename = "${path.module}/sonarqubekey.pem"
  content  = tls_private_key.myssh.private_key_pem
}