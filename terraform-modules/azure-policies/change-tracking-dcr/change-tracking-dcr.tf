data "azurerm_policy_definition" "change_tracking_dcr" {
  display_name = "[Preview]: Configure Windows Virtual Machines to be associated with a Data Collection Rule for ChangeTracking and Inventory"
}

resource "azurerm_subscription_policy_assignment" "change_tracking_dcr" {
  count                = var.subscription_id != null && var.location != null && var.dcr_resource_id != null ? 1 : 0
  name                 = "change-tracking-dcr"
  display_name         = "Configure Windows VM to be associated with a Data Collection Rule for ChangeTracking and Inventory"
  policy_definition_id = data.azurerm_policy_definition.change_tracking_dcr.id
  subscription_id      = var.subscription_id
  location             = var.location

  parameters = jsonencode({
    dcrResourceId = {
      value = var.dcr_resource_id
    }
  })

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "change_tracking_dcr_rbac" {
  count                = var.subscription_id != null && var.location != null && var.dcr_resource_id != null ? 1 : 0
  scope                = var.subscription_id
  role_definition_name = "Contributor"
  principal_id         = azurerm_subscription_policy_assignment.change_tracking_dcr[0].identity[0].principal_id
}

resource "azurerm_subscription_policy_remediation" "change_tracking_dcr_remediation" {
  count                = var.subscription_id != null && var.location != null && var.dcr_resource_id != null ? 1 : 0
  name                 = "change-tracking-dcr-remediation-task"
  subscription_id      = var.subscription_id
  policy_assignment_id = azurerm_subscription_policy_assignment.change_tracking_dcr[0].id
}
