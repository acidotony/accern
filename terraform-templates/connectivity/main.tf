
module "resource_group" {
  source              = "../../resource-group"
  resource_group_name = var.resourceGroupName
  location            = var.location
  tags                = var.tags
}

module "vnet_hub" {
  source              = "../../virtual-network"
  vnet_name           = var.vnet_hub_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  address_space       = var.address_space_hub
  tags                = var.tags
}



module "subnets_hub" {
  source                = "../../subnets"
  resource_group_name   = module.resource_group.resource_group_name
  virtual_network_name  = var.vnet_hub_name
  subnets               = var.subnets_hub
  depends_on            = [module.vnet_hub]

}

module "app_gateway" {
  source = "../../Application-Gateway"
  depends_on = [ module.resource_group ]
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
  backend_address_pool_name = var.applicationGatewayBackendAddressPoolName
  http_setting_name     = var.applicationGatewayHttpSettingName
  http_setting_cookie_based_affinity = var.applicationGatewayHttpSettingCookieBasedAffinity
  http_setting_path     = var.applicationGatewayHttpSettingPath
  http_setting_port     = var.applicationGatewayHttpSettingPort
  http_setting_protocol = var.applicationGatewayHttpSettingProtocol
  http_setting_request_timeout = var.applicationGatewayHttpSettingRequestTimeout
  listener_name         = var.applicationGatewayListenerName
  listener_protocol     = var.applicationGatewayListenerProtocol
  request_routing_rule_name = var.applicationGatewayRequestRoutingRuleName
  request_routing_rule_priority = var.applicationGatewayRequestRoutingRulePriority
  request_routing_rule_type = var.applicationGatewayRequestRoutingRuleType
  create_public_ip      = var.applicationGatewayCreatePublicIp
  public_ip_address_id  = var.applicationGatewayPublicIpAddressId
  subnet_id             = module.subnets_hub.subnet_ids[var.applicationGatewaySubnetName]
  tags                  = var.applicationGatewayTags
}
