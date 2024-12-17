output "subscription_policy_assignments" {
  description = "Policy assignments for ensuring network interfaces do not have public IPs at the subscription level"
  value = {
    for id, assignment in azurerm_subscription_policy_assignment.nics_no_pip :
    id => {
      id                 = assignment.id
      name               = assignment.name
      display_name       = assignment.display_name
      subscription_id    = assignment.subscription_id
      policy_definition  = assignment.policy_definition_id
      parameters         = assignment.parameters
    }
  }
}

output "management_group_policy_assignment" {
  description = "Policy assignment for ensuring network interfaces do not have public IPs at the management group level"
  value = length(azurerm_management_group_policy_assignment.nics_no_pip) > 0 ? {
    id                 = azurerm_management_group_policy_assignment.nics_no_pip[0].id
    name               = azurerm_management_group_policy_assignment.nics_no_pip[0].name
    display_name       = azurerm_management_group_policy_assignment.nics_no_pip[0].display_name
    management_group   = azurerm_management_group_policy_assignment.nics_no_pip[0].management_group_id
    policy_definition  = azurerm_management_group_policy_assignment.nics_no_pip[0].policy_definition_id
    parameters         = azurerm_management_group_policy_assignment.nics_no_pip[0].parameters
  } : null
}
