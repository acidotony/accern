output "subnet_names" {
  description = "The names of the subnets."
  value       = { for s in azurerm_subnet.subnet : s.name => s.name }
}

output "subnet_ids" {
  description = "The IDs of the subnets."
  value       = { for s in azurerm_subnet.subnet : s.name => s.id }
}

output "subnet_address_prefixes" {
  description = "The address prefixes of the subnets."
  value       = { for s in azurerm_subnet.subnet : s.name => s.address_prefixes }
}

output "subnet_service_endpoints" {
  description = "The service endpoints of the subnets."
  value       = { for s in azurerm_subnet.subnet : s.name => s.service_endpoints }
}

output "subnet_delegations" {
  description = "The delegations of the subnets."
  value = {
    for s in azurerm_subnet.subnet : s.name => {
      name                = s.delegation[0].name
      service_delegation  = {
        name    = s.delegation[0].service_delegation[0].name
        actions = s.delegation[0].service_delegation[0].actions
      }
    }
    if length(s.delegation) > 0
  }
}

