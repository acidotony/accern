data "azurerm_policy_definition" "missing_system_updates" {
  display_name = "Configure periodic checking for missing system updates on azure virtual machines"
}

resource "azurerm_subscription_policy_assignment" "missing_system_updates" {
  count                = var.subscription_id != null && var.location != null ? 1 : 0
  name                 = "missing-system-updates"
  display_name         = "Configure periodic checking for missing system updates on azure virtual machines"
  policy_definition_id = data.azurerm_policy_definition.missing_system_updates.id
  subscription_id      = var.subscription_id
  location             = var.location

  metadata = jsonencode(
    {
      parameterScopes = {
        locations = var.subscription_id
      }
    }
  )

  parameters = jsonencode({
    locations = {
      value = var.vm_locations
    }
    tagValues = {
      value = var.tag_values
    }
    osType = {
      value = var.os_type
    }
    tagOperator = {
      value = var.tag_operator
    }
    assessmentMode = {
      value = var.assessment_mode
    }
  })

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_subscription_policy_remediation" "missing_system_updates_remediation" {
  count                = var.subscription_id != null && var.location != null ? 1 : 0
  name                 = "missing-system-updates-remediation-task"
  subscription_id      = var.subscription_id
  policy_assignment_id = azurerm_subscription_policy_assignment.missing_system_updates[0].id
}
