// Terraform Providers version tested 4.11.0 and 4.12.0

resource "azurerm_virtual_network_peering" "main_to_hub" {
  count                     = var.create_hub ? 1 : 0
  name                      = "${var.vnet_main_name}-peer-main-to-hub"
  resource_group_name       = var.resource_group_name_main
  virtual_network_name      = var.virtual_network_name_main
  remote_virtual_network_id = var.remote_virtual_network_id_hub
  allow_virtual_network_access = true
  allow_forwarded_traffic   = true
}

resource "azurerm_virtual_network_peering" "hub_to_main" {
  count                     = var.create_hub ? 1 : 0
  name                      = "${var.vnet_hub_name}-peer-hub-to-main"
  resource_group_name       = var.resource_group_name_hub
  virtual_network_name      = var.virtual_network_name_hub
  remote_virtual_network_id = var.remote_virtual_network_id_main
  allow_virtual_network_access = true
  allow_forwarded_traffic   = true
}
