output "subscription_policy_definitions" {
  description = "Custom policy definitions created for enforcing tags at subscription scope"
  value = {
    for id, policy in azurerm_policy_definition.require_tags_on_rg_subscription_scope_custom :
    id => {
      id           = policy.id
      name         = policy.name
      display_name = policy.display_name
      policy_rule  = policy.policy_rule
      parameters   = policy.parameters
    }
  }
}

output "management_group_policy_definitions" {
  description = "Custom policy definitions created for enforcing tags at management group scope"
  value = {
    for id, policy in azurerm_policy_definition.require_tags_on_rg_mng_grp_scope_custom :
    id => {
      id           = policy.id
      name         = policy.name
      display_name = policy.display_name
      policy_rule  = policy.policy_rule
      parameters   = policy.parameters
    }
  }
}

output "subscription_policy_assignments" {
  description = "Custom policy assignments created for enforcing tags at subscription level"
  value = {
    for id, assignment in azurerm_subscription_policy_assignment.sub_require_tags_on_rg_custom :
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
  description = "Custom policy assignments created for enforcing tags at management group level"
  value = {
    for id, assignment in azurerm_management_group_policy_assignment.mng_require_tags_on_rg_custom :
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
