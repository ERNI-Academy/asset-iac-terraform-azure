// ------------------------------------------------------------------------------
// module configuration variables
// ------------------------------------------------------------------------------
variable "location" {
  type        = string
  default     = "West Europe"
  description = "The location"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group"
}

variable "admin_username" {
  description = "Azure VM Username"
}

variable "tags" {
  type = map(any)

  default = {
    Environment = "EDD DEV"
    Dept        = "ERNI-Services"
  }
}

variable "domain_name" {
  type        = string
  description = "Domain name for the fqdn"
}

variable "virtual_network_name" {
  type        = string
  description = "Virtual network name"
}

variable "subnet_name" {
  type        = string
  description = "Subnet name"
}

variable "public_ip_name" {
  type        = string
  description = "Public IP name"
}

variable "nsg_name" {
  type        = string
  description = "Network security group name"
}

variable "network_interface_name" {
  type        = string
  description = "Network interface name"
}

variable "ip_config_name" {
  type        = string
  description = "IP Configuration name"
}

variable "linux_vm_name" {
  type        = string
  description = "Virtual Machine Name"
}

variable "comp_name" {
  type        = string
  description = "Computer name"
}

variable "os_disk_name" {
  type        = string
  description = "OS Disk Name"
}