// ------------------------------------------------------------------------------
// version restrictions
// ------------------------------------------------------------------------------
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.13.0"
    }

    null = "~> 2.1"
  }
}
