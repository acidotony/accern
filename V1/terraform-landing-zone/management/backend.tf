terraform {
  backend "azurerm" {
    resource_group_name = "acn-tf-prd-use2-rg-01"
    storage_account_name = "acntfstateprdst01"
    container_name = "accern-management"
    key = "management.terraform.tfstate"
  }
}