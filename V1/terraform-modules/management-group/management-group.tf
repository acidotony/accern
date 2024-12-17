resource "azurerm_management_group" "this" {
  for_each = { for mg in var.management_groups : mg.name => mg }

  name                     = each.value.name
  display_name             = each.value.display_name
  parent_management_group_id = each.value.parent_id
}

resource "azurerm_management_group_subscription_association" "subscriptions" {
  for_each = { for mg in var.management_groups : mg.name => mg if mg.subscription_ids != null }

  management_group_id = azurerm_management_group.this[each.key].id

  subscription_id = each.value.subscription_ids[0]
}
