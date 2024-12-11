data "azurerm_policy_definition" "vm_backups" {
  display_name = "Configure backup on virtual machines with a given tag to an existing recovery services vault in the same location"
}

resource "azurerm_subscription_policy_assignment" "vm_backups" {
  count                = var.subscription_id != null && var.location != null && var.vault_id != null && var.backup_policy_id != null ? 1 : 0
  name                 = var.name
  display_name         = "Configure backup on virtual machines with a given tag to an existing recovery services vault in the same location"
  policy_definition_id = data.azurerm_policy_definition.vm_backups.id
  subscription_id      = var.subscription_id
  location             = var.location

  metadata = jsonencode(
    {
      parameterScopes = {
        vaultLocation  = var.subscription_id
        backupPolicyId = var.vault_id
      }
    }
  )

  parameters = jsonencode({
    backupPolicyId = {
      value = var.backup_policy_id
    }
    vaultLocation = {
      value = var.vault_location
    }
    inclusionTagValue = {
      value = var.inclusion_tag_value
    }
    inclusionTagName = {
      value = var.inclusion_tag_name
    }
    effect = {
      value = var.effect
    }
  })

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "vm_backups_rbac" {
  count                = var.subscription_id != null && var.location != null && var.vault_id != null && var.backup_policy_id != null ? 1 : 0
  scope                = var.subscription_id
  role_definition_name = "Contributor"
  principal_id         = azurerm_subscription_policy_assignment.vm_backups[0].identity[0].principal_id
}

resource "azurerm_subscription_policy_remediation" "vm_backups_remediation" {
  count                = var.subscription_id != null && var.location != null && var.vault_id != null && var.backup_policy_id != null ? 1 : 0
  name                 = "${var.name}-remediation-task"
  subscription_id      = var.subscription_id
  policy_assignment_id = azurerm_subscription_policy_assignment.vm_backups[0].id

  lifecycle {
    replace_triggered_by = [
      azurerm_subscription_policy_assignment.vm_backups.parameters
    ]
  }
}
