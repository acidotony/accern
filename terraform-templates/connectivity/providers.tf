terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.12.0"
    }
  }
}
provider "azurerm" {
  features {}
  use_cli = true
  subscription_id = "12302488-c84e-40e3-b782-3f748417b5fb"
}