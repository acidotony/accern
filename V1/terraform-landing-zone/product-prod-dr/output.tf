output "vnet_spoke_rg" {
  description = "Resource Group of the spoke virtual network"
  value       = var.resource_group_name
  
}

output "vnet_spoke_id" {
  description = "ID of the spoke virtual network"
  value       = module.vnet_spoke.vnet_id
}

output "vnet_spoke_name" {
  description = "Name of the spoke virtual network"
  value        = module.vnet_spoke.vnet_name
  
}



