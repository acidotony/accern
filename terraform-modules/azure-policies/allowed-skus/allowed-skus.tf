terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.13.0"
    }
  }
}

data "azurerm_policy_definition" "allowed_skus" {
  display_name = "Allowed virtual machine size SKUs"
}

resource "azurerm_subscription_policy_assignment" "allowed_skus" {
  for_each = { for id in var.subscription_ids : id => id }

  name                 = "allowed-skus-${each.key}"
  display_name         = "Allowed virtual machine size SKUs"
  policy_definition_id = data.azurerm_policy_definition.allowed_skus.id
  subscription_id      = "/subscriptions/${each.key}"

  metadata = jsonencode({
    parameterScopes = {
      listOfAllowedSKUs = each.key
    }
  })

  parameters = jsonencode({
    listOfAllowedSKUs = {
      value = var.skus
    }
  })
}

resource "azurerm_management_group_policy_assignment" "allowed_skus" {
  count = length(var.skus) > 0 ? 1 : 0

  name                 = "allowed-skus"
  display_name         = "Allowed virtual machine size SKUs"
  policy_definition_id = data.azurerm_policy_definition.allowed_skus.id
  management_group_id  = var.management_group_id

  metadata = jsonencode({
    parameterScopes = {
      listOfAllowedSKUs = var.management_group_id
    }
  })

  parameters = jsonencode({
    listOfAllowedSKUs = {
      value = var.skus
    }
  })
}