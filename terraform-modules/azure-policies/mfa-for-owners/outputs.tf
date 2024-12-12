output "subscription_policy_assignments" {
  description = "The policy assignments created for MFA enforcement at the subscription level"
  value = {
    for id, assignment in azurerm_subscription_policy_assignment.owner-mfa-enabled :
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

output "management_group_policy_assignments" {
  description = "The policy assignments created for MFA enforcement at the management group level"
  value = {
    for id, assignment in azurerm_management_group_policy_assignment.owner-mfa-enabled :
    id => {
      id                 = assignment.id
      name               = assignment.name
      display_name       = assignment.display_name
      management_group   = assignment.management_group_id
      policy_definition  = assignment.policy_definition_id
      parameters         = assignment.parameters
    }
  }
}
