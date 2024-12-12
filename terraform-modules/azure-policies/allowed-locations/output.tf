output "subscription_policy_assignments" {
  description = "The policy assignments created for the subscriptions"
  value = {
    for id, assignment in azurerm_subscription_policy_assignment.allowed_locations :
    id => {
      id                 = assignment.id
      name               = assignment.name
      display_name       = assignment.display_name
      subscription_id    = assignment.subscription_id
      policy_definition  = assignment.policy_definition_id
      parameters         = assignment.parameters
      metadata           = assignment.metadata
    }
  }
}

output "management_group_policy_assignment" {
  description = "The policy assignment created for the management group"
  value = {
    id                 = azurerm_management_group_policy_assignment.allowed_locations[0].id
    name               = azurerm_management_group_policy_assignment.allowed_locations[0].name
    display_name       = azurerm_management_group_policy_assignment.allowed_locations[0].display_name
    management_group   = azurerm_management_group_policy_assignment.allowed_locations[0].management_group_id
    policy_definition  = azurerm_management_group_policy_assignment.allowed_locations[0].policy_definition_id
    parameters         = azurerm_management_group_policy_assignment.allowed_locations[0].parameters
    metadata           = azurerm_management_group_policy_assignment.allowed_locations[0].metadata
  }
  depends_on = [azurerm_management_group_policy_assignment.allowed_locations]
}
