###### Deplyment Flags #####

deploy_app_gateway = true

###### Global ######
resourceGroupName = "acn-net-prd-use2-rg-01" 
location          = "eastus2"
tags = {
  environment = "Management"
  project     = "Accern"
  deploymentBy = "Terraform"
}

address_space_hub = ["10.10.0.0/22"]

subnets_hub = {
  "acn-hub-prd-use2-appgw-snet" = { 
    address_prefixes        = ["10.10.0.64/26"]  
    service_endpoints       = []
    delegation              = false
    delegation_name         = ""
    service_delegation_name = ""
    actions                 = []
  }
  "acn-hub-prd-use2-gateway-snet" = { ## Align names to standard: agregar/renombrar a las otras necesarias del hub / AzureFirewall - VirtualGateway
    address_prefixes        = ["10.10.0.128/26"]  
    service_endpoints       = []
    delegation              = false
    delegation_name         = ""
    service_delegation_name = ""
    actions                 = []
  }
}


vnet_hub_name  = "acn-hub-prd-use2-vnet-01" 

#### Application Gateway NSG ######
applicationGatewayNsgName = "acn-appgw-prd-use2-snet-nsg" 

applicationGatewayNsgRules = [
  {
    name                       = "Allow-HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "Allow-HTTPS"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "Allow-AGV2-Ports"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "65200-65535"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]

#### Firewall Policy ####
firewallPolicyName = "acn-appgw-prd-use2-waf-01"
firewallPolicyTags = {
  environment = "Management"
  project     = "Accern"
  deploymentBy = "Terraform"
}

#### Application Gateway #######
applicationGatewayResourceGroupName   = "acn-net-prd-use2-rg-01" 
applicationGatewayLocation            = "eastus2"
applicationGatewayName                = "acn-hub-prd-use2-agw-01" 
applicationGatewaySkuName             = "WAF_v2" 
applicationGatewaySkuTier             = "WAF_v2" 
applicationGatewaySkuCapacity         = 2
applicationGatewaySubnetName          = "acn-hub-prd-use2-appgw-snet" 
applicationGatewayGatewayIpConfigName = "gateway-ip-config"
applicationGatewayFrontendPortName    = "frontend-port"
applicationGatewayFrontendPortNumber  = 80
applicationGatewayFrontendIpConfigurationName = "acn-hub-prd-use2-appgw-pip" 
applicationGatewayBackendAddressPoolName      = "backend-pool"
applicationGatewayHttpSettingName             = "http-settings"
applicationGatewayHttpSettingCookieBasedAffinity = "Disabled"
applicationGatewayHttpSettingPath             = "/path1/"
applicationGatewayHttpSettingPort             = 80
applicationGatewayHttpSettingProtocol         = "Http"
applicationGatewayHttpSettingRequestTimeout   = 60
applicationGatewayListenerName                = "http-listener"
applicationGatewayListenerProtocol            = "Http"
applicationGatewayRequestRoutingRuleName      = "request-routing-rule"
applicationGatewayRequestRoutingRulePriority  = 10
applicationGatewayRequestRoutingRuleType      = "Basic"
applicationGatewayCreatePublicIp              = true
applicationGatewayPublicIpAddressId           = null
applicationGatewayTags = {
  environment = "Production"
  deploymentBy = "Terraform"
}



