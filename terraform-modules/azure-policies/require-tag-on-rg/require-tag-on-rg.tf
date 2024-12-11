# Policy definitions for subscription-level scope
resource "azurerm_policy_definition" "require_tags_on_rg_subscription_scope_custom" {
  for_each     = toset(var.subscription_ids)
  name         = "require-tags-on-rg-${substr(each.key, 0, 10)}" # Ensure unique name for each subscription
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Require tags on resource groups except those starting with 'MC_' at Subscription Scope"

  //subscription_id = each.key # Ensure the policy is scoped to the subscription

  policy_rule = <<POLICY_RULE
  {
    "if": {
      "field": "type",
      "equals": "Microsoft.Resources/subscriptions"
    },
    "then": {
      "effect": "auditIfNotExists",
      "details": {
        "type": "Microsoft.Resources/tags",
        "existenceCondition": {
          "allOf": [
            {
              "field": "[concat('tags[', parameters('tagNames')[0], ']')]",
              "exists": "true"
            },
            {
              "field": "[concat('tags[', parameters('tagNames')[1], ']')]",
              "exists": "true"
            }
          ]
        }
      }
    }
  }
  POLICY_RULE

  parameters = <<PARAMETERS
  {
    "tagNames": {
      "type": "Array",
      "metadata": {
        "description": "The names of the tags to enforce on resource groups."
      }
    }
  }
  PARAMETERS
}

# Policy definitions for management group scope
resource "azurerm_policy_definition" "require_tags_on_rg_mng_grp_scope_custom" {
  for_each     = toset(var.management_group_ids)
  name         = "require-tags-on-rg-${substr(each.key, length(each.key) - 5, 5)}" # Ensure unique name for each management group
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Require tags on resource groups except those starting with 'MC_' at Management Group Scope"

  management_group_id = each.key # Scope the policy definition to the management group

  policy_rule = <<POLICY_RULE
  {
    "if": {
      "field": "type",
      "equals": "Microsoft.Management/managementGroups"
    },
    "then": {
      "effect": "auditIfNotExists",
      "details": {
        "type": "Microsoft.Resources/tags",
        "existenceCondition": {
          "allOf": [
            {
              "field": "[concat('tags[', parameters('tagNames')[0], ']')]",
              "exists": "true"
            },
            {
              "field": "[concat('tags[', parameters('tagNames')[1], ']')]",
              "exists": "true"
            }
          ]
        }
      }
    }
  }
  POLICY_RULE

  parameters = <<PARAMETERS
  {
    "tagNames": {
      "type": "Array",
      "metadata": {
        "description": "The names of the tags to enforce on resource groups."
      }
    }
  }
  PARAMETERS
}

# Policy assignment for subscriptions
resource "azurerm_subscription_policy_assignment" "sub_require_tags_on_rg_custom" {
  for_each = { for id in var.subscription_ids : id => id }

  name                 = "cus-sub-pol-tags-${substr(each.key, 0, 6)}"
  display_name         = "Custom: Require tags (${join(", ", var.tags)}) on resource groups (except MC_*)"
  policy_definition_id = azurerm_policy_definition.require_tags_on_rg_subscription_scope_custom[each.key].id # Reference specific policy
  subscription_id      = "/subscriptions/${each.key}"
  parameters = jsonencode({
    "tagNames": {
      "value": var.tags
    }
  })
}

# Policy assignment for management groups
resource "azurerm_management_group_policy_assignment" "mng_require_tags_on_rg_custom" {
  for_each = { for id in var.management_group_ids : id => id }

  name                 = "cus-mng-pol-tags-${substr(each.key, length(each.key) - 5, 5)}"
  display_name         = "Custom: Require tags (${join(", ", var.tags)}) on resource groups (except MC_*)"
  policy_definition_id = azurerm_policy_definition.require_tags_on_rg_mng_grp_scope_custom[each.key].id # Reference specific policy
  management_group_id  = each.value

  parameters = jsonencode({
    "tagNames": {
      "value": var.tags
    }
  })
}
