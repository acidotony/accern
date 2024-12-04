output "application_gateway_id" {
  description = "The ID of the Application Gateway"
  value       = azurerm_application_gateway.network.id
}

output "application_gateway_name" {
  description = "The name of the Application Gateway"
  value       = azurerm_application_gateway.network.name
}


output "application_gateway_public_ip" {
  description = "The public IP address ID of the Application Gateway"
  value       = azurerm_application_gateway.network.frontend_ip_configuration[0].public_ip_address_id
}

