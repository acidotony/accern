data "azurerm_policy_definition" "recurring_updates" {
  display_name = "Schedule recurring updates using Azure Update Manager"
}

resource "azurerm_subscription_policy_assignment" "recurring_updates" {
  count                = var.subscription_id != null && var.location != null && var.mnt_config_resource_id != null ? 1 : 0
  name                 = "recurring-updates"
  display_name         = "Schedule recurring updates using Azure Update Manager"
  policy_definition_id = data.azurerm_policy_definition.recurring_updates.id
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
    maintenanceConfigurationResourceId = {
      value = var.mnt_config_resource_id
    }
    tagValues = {
      value = var.tag_values
    }
    effect = {
      value = var.effect
    }
    resourceGroups = {
      value = var.resource_groups
    }
    tagOperator = {
      value = var.tag_operator
    }
    locations = {
      value = var.vm_locations
    }
    operatingSystemTypes = {
      value = var.operating_system_types
    }
  })

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_subscription_policy_remediation" "recurring_updates_remediation" {
  count                = var.subscription_id != null && var.location != null && var.mnt_config_resource_id != null ? 1 : 0
  name                 = "recurring-updates-remediation-task"
  subscription_id      = var.subscription_id
  policy_assignment_id = azurerm_subscription_policy_assignment.recurring_updates[0].id
}
