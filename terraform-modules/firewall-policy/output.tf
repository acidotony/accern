output "waf_policy_id" {
  description = "The ID of the Web Application Firewall Policy"
  value       = azurerm_firewall_policy.this.id
}
