terraform {
  backend "azurerm" {
    resource_group_name = "optimus-test-global"
    storage_account_name = "opttesttfstate220241129"
    container_name = "accern-product-prd"
    key = "productprod.terraform.tfstate"
  }
}