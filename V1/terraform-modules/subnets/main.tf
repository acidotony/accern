// Terraform Providers version tested 4.11.0 and 4.12.0

resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = each.value.address_prefixes
  service_endpoints    = each.value.service_endpoints
  private_link_service_network_policies_enabled = var.private_link_service_network_policies_enabled

  dynamic "delegation" {
    for_each = each.value.delegation ? [1] : []
    content {
      name = each.value.delegation_name

      service_delegation {
        name    = each.value.service_delegation_name
        actions = each.value.actions
      }
    }
  }
}


