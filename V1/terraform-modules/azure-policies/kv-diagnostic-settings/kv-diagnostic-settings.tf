data "azurerm_policy_definition" "kv_diagnostic_settings" {
  display_name = "Deploy Diagnostic Settings for Key Vault to Log Analytics workspace"
}

resource "azurerm_subscription_policy_assignment" "kv_diagnostic_settings" {
  count                = var.subscription_id != null && var.location != null && var.log_analytics != null ? 1 : 0
  name                 = "kv-diagnostic-settings"
  display_name         = "Deploy Diagnostic Settings for Key Vault to Log Analytics workspace"
  policy_definition_id = data.azurerm_policy_definition.kv_diagnostic_settings.id
  subscription_id      = var.subscription_id
  location             = var.location

  metadata = jsonencode(
    {
      parameterScopes = {
        logAnalytics = var.subscription_id
      }
    }
  )

  parameters = jsonencode({
    logAnalytics = {
      value = var.log_analytics
    }
    effect = {
      value = var.effect
    }
    profileName = {
      value = var.profile_name
    }
    metricsEnabled = {
      value = var.metrics_enabled
    }
    logsEnabled = {
      value = var.logs_enabled
    }
  })

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_subscription_policy_remediation" "kv_diagnostic_settings_remediation" {
  count                = var.subscription_id != null && var.location != null && var.log_analytics != null ? 1 : 0
  name                 = "kv-diagnostic-settings-remediation-task"
  subscription_id      = var.subscription_id
  policy_assignment_id = azurerm_subscription_policy_assignment.kv_diagnostic_settings[0].id
}
