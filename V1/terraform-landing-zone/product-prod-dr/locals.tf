locals {
  valid_nodepool_skus = jsondecode(file("westus2_valid_nodepool_skus.json"))
}
