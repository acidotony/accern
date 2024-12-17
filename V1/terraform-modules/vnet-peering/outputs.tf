output "main_to_hub_peering_id" {
  value = try(azurerm_virtual_network_peering.main_to_hub[0].id, "")
  description = "The resource ID of the VNet peering from Main to Hub"
}

output "hub_to_main_peering_id" {
  value = try(azurerm_virtual_network_peering.hub_to_main[0].id, "")
  description = "The resource ID of the VNet peering from Hub to Main"
}