provider "azurerm" {
    features { }
    tenant_id       = "ea12a4cf-7043-4210-99c5-a80022f468be"
    subscription_id = "12302488-c84e-40e3-b782-3f748417b5fb"
  
}

terraform {
  required_version = ">= 1.9.0, < 2.0.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.12.0"
    }
  }
}