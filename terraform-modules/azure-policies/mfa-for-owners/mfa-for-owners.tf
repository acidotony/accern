data "azurerm_policy_definition" "owner-mfa-enabled" {
  display_name = "Accounts with owner permissions on Azure resources should be MFA enabled"
}

resource "azurerm_subscription_policy_assignment" "owner-mfa-enabled" {
  for_each = { for id in var.subscription_ids : id => "/subscriptions/${id}" } # Convert to full resource ID
  name                 = "mfa-${substr(each.key, 0, 20)}" # Ensure name length is within limits
  display_name         = "Accounts with owner permissions on Azure resources should be MFA enabled"
  policy_definition_id = data.azurerm_policy_definition.owner-mfa-enabled.id
  subscription_id      = each.value

  parameters = jsonencode({
    effect = {
      value = "AuditIfNotExists" # Set "Disabled" to turn off the policy
    }
  })
}

resource "azurerm_management_group_policy_assignment" "owner-mfa-enabled" {
  for_each = { for id in var.management_group_ids : id => id }
  
  # Use a valid and short name for the assignment
  name                 = "mfa-${substr(each.key, length(each.key) - 5, 5)}" # Extract the last 5 characters for uniqueness
  display_name         = "Accounts with owner permissions on Azure resources should be MFA enabled"
  policy_definition_id = data.azurerm_policy_definition.owner-mfa-enabled.id
  management_group_id  = each.value

  parameters = jsonencode({
    effect = {
      value = "AuditIfNotExists" # Set "Disabled" to turn off the policy
    }
  })
}