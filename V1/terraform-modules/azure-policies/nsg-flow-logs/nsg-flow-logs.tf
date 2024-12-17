resource "azurerm_subscription_policy_assignment" "nsg_flow_logs" {
  count                = var.subscription_id != null && var.location != null && var.workspace_id != null ? 1 : 0
  name                 = "nsg-flow"
  display_name         = "Deploys NSG flow logs and traffic analytics to Log Analytics"
  policy_definition_id = var.policy_definition_id
  subscription_id      = var.subscription_id
  location             = var.location

  parameters = jsonencode({
    workspace = {
      value = var.workspace_id
    }
  })

  identity {
    type = "SystemAssigned"
  }
}

locals {
  roles = ["Network Contributor", "Storage Account Key Operator Service Role", "Log Analytics Contributor", "Storage Account Contributor", "Contributor"]
}

resource "azurerm_role_assignment" "nsg_flow_logs_rbac" {
  for_each = var.subscription_id != null && var.location != null && var.workspace_id != null ? toset(local.roles) : toset([])

  scope                = var.subscription_id
  role_definition_name = each.value
  principal_id         = azurerm_subscription_policy_assignment.nsg_flow_logs[0].identity[0].principal_id
}

resource "azurerm_subscription_policy_remediation" "nsg_flow_logs_remediation" {
  count                = var.subscription_id != null && var.location != null && var.workspace_id != null ? 1 : 0
  name                 = "nsg-flow-remediation-task"
  subscription_id      = var.subscription_id
  policy_assignment_id = azurerm_subscription_policy_assignment.nsg_flow_logs[0].id
}
