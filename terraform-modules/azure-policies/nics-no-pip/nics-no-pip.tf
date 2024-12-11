terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.13.0"
    }
  }
}
data "azurerm_policy_definition" "nics_no_pip" {
  display_name = "Network interfaces should not have public IPs"
}

resource "azurerm_subscription_policy_assignment" "nics_no_pip" {
  for_each = { for id in var.subscription_ids : id => id }

  name                 = "nics-no-pip-${each.key}"
  display_name         = "Network interfaces should not have public IPs"
  policy_definition_id = data.azurerm_policy_definition.nics_no_pip.id
  subscription_id      = "/subscriptions/${each.key}"

  parameters = jsonencode({})
}

resource "azurerm_management_group_policy_assignment" "nics_no_pip" {
  count = length(var.management_group_id) > 0 ? 1 : 0

  name                 = "nics-no-pip"
  display_name         = "Network interfaces should not have public IPs"
  policy_definition_id = data.azurerm_policy_definition.nics_no_pip.id
  management_group_id  = var.management_group_id

  parameters = jsonencode({})
}