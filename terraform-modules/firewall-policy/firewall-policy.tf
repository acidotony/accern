resource "azurerm_firewall_policy" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  sku_tier = var.sku_tier

  threat_intel_mode = var.threat_intel_mode

  identity {
    type = "UserAssigned"
    identity_ids = var.identity_ids
  }

  intrusion_detection {
    mode = var.intrusion_detection_mode

    signature_overrides = var.signature_overrides
    bypass_traffic = var.bypass_traffic
  }
}

output "firewall_policy_id" {
  value = azurerm_firewall_policy.this.id
}