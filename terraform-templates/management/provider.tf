terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.13.0"
    }
  }
}

provider "azurerm" {
  
  features {}
  subscription_id = "e12ce4d3-a17b-4aa7-8b8a-10abb4546edf"
}
