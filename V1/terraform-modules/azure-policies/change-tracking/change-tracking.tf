data "azurerm_policy_definition" "change_tracking" {
  display_name = "[Preview]: Configure ChangeTracking Extension for Windows virtual machines"
}

resource "azurerm_subscription_policy_assignment" "change_tracking" {
  count                = var.subscription_id != null && var.location != null ? 1 : 0
  name                 = "change-tracking"
  display_name         = "Configure Windows virtual machines to automatically install the ChangeTracking Extension"
  policy_definition_id = data.azurerm_policy_definition.change_tracking.id
  subscription_id      = var.subscription_id
  location             = var.location

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "change_tracking_rbac" {
  count                = var.subscription_id != null && var.location != null ? 1 : 0
  scope                = var.subscription_id
  role_definition_name = "Contributor"
  principal_id         = azurerm_subscription_policy_assignment.change_tracking[0].identity[0].principal_id
}

resource "azurerm_subscription_policy_remediation" "change_tracking_remediation" {
  count                = var.subscription_id != null && var.location != null ? 1 : 0
  name                 = "change-tracking-remediation-task"
  subscription_id      = var.subscription_id
  policy_assignment_id = azurerm_subscription_policy_assignment.change_tracking[0].id
}
