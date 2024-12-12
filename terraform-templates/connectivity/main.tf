module "resource_group" {
  source              = "../../terraform-modules/resource-group"
  resource_group_name = var.resourceGroupName
  location            = var.location
  tags                = var.tags
}

module "vnet_hub" {
  source              = "../../terraform-modules/virtual-network"
  vnet_name           = var.vnet_hub_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  address_space       = var.address_space_hub
  tags                = var.tags
}

module "subnets_hub" {
  source                = "../../terraform-modules/subnets"
  resource_group_name   = module.resource_group.resource_group_name
  virtual_network_name  = var.vnet_hub_name
  subnets               = var.subnets_hub
  depends_on            = [module.vnet_hub]
}

module "application_gateway_nsg" {
  source              = "../../terraform-modules/network-security-group"
  name                = var.applicationGatewayNsgName
  location            = var.applicationGatewayLocation
  resource_group_name = var.applicationGatewayResourceGroupName
  rules               = var.applicationGatewayNsgRules

  depends_on = [module.resource_group, module.subnets_hub]
}

resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = module.subnets_hub.subnet_ids[var.applicationGatewaySubnetName]
  network_security_group_id = module.application_gateway_nsg.id
}

module "app_gateway" {
  source = "../../terraform-modules/app-gateway"
  count  = var.deploy_app_gateway ? 1 : 0
  resource_group_name   = var.applicationGatewayResourceGroupName
  location              = var.applicationGatewayLocation
  appgtw_name           = var.applicationGatewayName
  sku_name              = var.applicationGatewaySkuName
  sku_tier              = var.applicationGatewaySkuTier
  sku_capacity          = var.applicationGatewaySkuCapacity
  gateway_ip_config_name = var.applicationGatewayGatewayIpConfigName
  frontend_port_name    = var.applicationGatewayFrontendPortName
  frontend_port_number  = var.applicationGatewayFrontendPortNumber
  frontend_ip_configuration_name = var.applicationGatewayFrontendIpConfigurationName
  backend_address_pool_name      = var.applicationGatewayBackendAddressPoolName
  http_setting_name     = var.applicationGatewayHttpSettingName
  http_setting_cookie_based_affinity = var.applicationGatewayHttpSettingCookieBasedAffinity
  http_setting_path     = var.applicationGatewayHttpSettingPath
  http_setting_port     = var.applicationGatewayHttpSettingPort
  http_setting_protocol = var.applicationGatewayHttpSettingProtocol
  http_setting_request_timeout = var.applicationGatewayHttpSettingRequestTimeout
  listener_name         = var.applicationGatewayListenerName
  listener_protocol     = var.applicationGatewayListenerProtocol
  request_routing_rule_name     = var.applicationGatewayRequestRoutingRuleName
  request_routing_rule_priority = var.applicationGatewayRequestRoutingRulePriority
  request_routing_rule_type     = var.applicationGatewayRequestRoutingRuleType
  create_public_ip      = var.applicationGatewayCreatePublicIp
  public_ip_address_id  = var.applicationGatewayPublicIpAddressId
  subnet_id             = module.subnets_hub.subnet_ids[var.applicationGatewaySubnetName]

  firewall_policy_name = var.firewallPolicyName

  tags                  = var.applicationGatewayTags

  depends_on            = [module.resource_group]
}
