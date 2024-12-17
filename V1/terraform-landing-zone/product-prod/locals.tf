locals {
  valid_nodepool_skus = jsondecode(file("eastus2_valid_nodepool_skus.json"))
}
