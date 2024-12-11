output "management_group_ids" {
  description = "The IDs of the created management groups."
  value       = { for mg in azurerm_management_group.this : mg.name => mg.id }
}