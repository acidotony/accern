resource "azurerm_application_gateway" "this" {
  name                = var.appgtw_name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = var.sku_capacity
  }

  gateway_ip_configuration {
    name      = var.gateway_ip_config_name
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = var.frontend_port_name
    port = var.frontend_port_number
  }

  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.this.id
  }

  backend_address_pool {
    name = var.backend_address_pool_name
  }

  backend_http_settings {
    name                  = var.http_setting_name
    cookie_based_affinity = var.http_setting_cookie_based_affinity
    path                  = var.http_setting_path
    port                  = var.http_setting_port
    protocol              = var.http_setting_protocol
    request_timeout       = var.http_setting_request_timeout
  }

  http_listener {
    name                           = var.listener_name
    frontend_ip_configuration_name = var.frontend_ip_configuration_name
    frontend_port_name             = var.frontend_port_name
    protocol                       = var.listener_protocol
  }

  request_routing_rule {
    name                       = var.request_routing_rule_name
    rule_type                  = var.request_routing_rule_type
    priority                   = var.request_routing_rule_priority
    http_listener_name         = var.listener_name
    backend_address_pool_name  = var.backend_address_pool_name
    backend_http_settings_name = var.http_setting_name
  }

  firewall_policy_id = azurerm_web_application_firewall_policy.this.id


  tags = var.tags
}

resource "azurerm_web_application_firewall_policy" "this" {
  name                = var.firewall_policy_name
  resource_group_name = var.resource_group_name
  location            = var.location

  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
    }
  }

  tags = var.tags
}

resource "azurerm_public_ip" "this" {
  name                = "${var.appgtw_name}-public-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.app_gateway_public_ip_allocation_method
  sku                 = var.app_gateway_public_ip_sku

  tags = var.tags
}