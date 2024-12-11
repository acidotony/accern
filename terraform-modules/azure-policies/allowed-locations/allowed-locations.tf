terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.13.0"
    }
  }
}



data "azurerm_policy_definition" "allowed_locations" {
  display_name = "Allowed locations"
}

resource "azurerm_subscription_policy_assignment" "allowed_locations" {
  for_each = { for id in var.subscription_ids : id => id }

  name                 = "allowed-locations-${each.key}"
  display_name         = "Allowed locations"
  policy_definition_id = data.azurerm_policy_definition.allowed_locations.id
  subscription_id = "/subscriptions/${each.key}"


  metadata = jsonencode({
    parameterScopes = {
      listOfAllowedLocations = each.key
    }
  })

  parameters = jsonencode({
    listOfAllowedLocations = {
      value = var.locations
    }
  })
}

resource "azurerm_management_group_policy_assignment" "allowed_locations" {
  count = length(var.locations) > 0 ? 1 : 0

  name                 = "allowed-locations"
  display_name         = "Allowed locations"
  policy_definition_id = data.azurerm_policy_definition.allowed_locations.id
  management_group_id  = var.management_group_id

  metadata = jsonencode({
    parameterScopes = {
      listOfAllowedLocations = var.management_group_id
    }
  })

  parameters = jsonencode({
    listOfAllowedLocations = {
      value = var.locations
    }
  })
}