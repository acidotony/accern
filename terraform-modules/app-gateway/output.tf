output "application_gateway_id" {
  value = azurerm_application_gateway.this.id
}

output "application_gateway_name" {
  value = azurerm_application_gateway.this.name
}

output "application_gateway_public_ip" {
  value = azurerm_application_gateway.this.frontend_ip_configuration[0].public_ip_address_id
}
