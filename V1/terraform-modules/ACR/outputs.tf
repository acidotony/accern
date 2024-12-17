output "acr_id" {
  description = "The unique identifier for the Azure Container Registry."
  value       = azurerm_container_registry.acr.id
}

output "acr_login_server" {
  description = "The URL used to log into the Azure Container Registry."
  value       = azurerm_container_registry.acr.login_server
}

output "acr_admin_username" {
  description = "The admin username for the Azure Container Registry, if admin is enabled."
  value       = var.admin_enabled ? azurerm_container_registry.acr.admin_username : ""
  sensitive   = true
}

output "acr_admin_password" {
  description = "The admin password for the Azure Container Registry, if admin is enabled."
  value       = var.admin_enabled ? azurerm_container_registry.acr.admin_password : ""
  sensitive   = true
}
