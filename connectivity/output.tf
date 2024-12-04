output "resource_group_name" {
  description = "Resource Group Name of the hub virtual network"
  value = var.resourceGroupName
}

output "vnet_hub_id" {
  description = "ID of the hub virtual network"
  value       = module.vnet_hub.vnet_id
}

output "vnet_hub_name" {
  description = "Name of the hub virtual network"
  value       = module.vnet_hub.vnet_name
  
}


output "address_space" {
  description = "Address space for virtual networks"
  value       = module.vnet_hub.address_space
  
}


output "address_prefixes" {
  description = "Address prefixes for virtual networks"
  value      = module.subnets_hub.subnet_address_prefixes
}

output "appgtw_subnet_id" {
  description = "ID of the hub subnet"
  value        = module.subnets_hub.subnet_ids
  
}


