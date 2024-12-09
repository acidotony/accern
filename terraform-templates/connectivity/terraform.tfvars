###### Deplyment Flags #####

deploy_app_gateway = true


###### Global ######
resourceGroupName = "acn-hub-eastus2-rg"
location          = "eastus2"
tags = {
  environment = "Management"
  project     = "Accern"
  deploymentBy = "Terraform"
}

address_space_hub = ["10.0.0.0/21"]

subnets_hub = {
  "acn-appgw-eastus2-01-subnet" = {
    address_prefixes        = ["10.0.5.0/24"]  
    service_endpoints       = []
    delegation              = false
    delegation_name         = ""
    service_delegation_name = ""
    actions                 = []
  }
  "acn-web-eastus2-01-subnet" = {
    address_prefixes        = ["10.0.4.0/24"]  
    service_endpoints       = []
    delegation              = false
    delegation_name         = ""
    service_delegation_name = ""
    actions                 = []
  }
}

nsg_appgw_name = "nsg-appgw-eastus2-01"
vnet_hub_name  = "acn-hub-eastus2-01-vnet"

#### Application Gateway #######
applicationGatewayResourceGroupName   = "acn-hub-eastus2-rg"
applicationGatewayLocation            = "eastus2"
applicationGatewayName                = "acn-hub-eastus2-01-appgtw"
applicationGatewaySkuName             = "Standard_v2"
applicationGatewaySkuTier             = "Standard_v2"
applicationGatewaySkuCapacity         = 2
applicationGatewaySubnetName          = "acn-appgw-eastus2-01-subnet"
applicationGatewayGatewayIpConfigName = "gateway-ip-config"
applicationGatewayFrontendPortName    = "frontend-port"
applicationGatewayFrontendPortNumber  = 80
applicationGatewayFrontendIpConfigurationName = "frontend-ip-config"
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

#### VPN Point-to-Site #######

vpnP2sGatewayName           = "acn-hub-eastus2-vpn"
vpnP2sGatewayScaleUnit      = 1
vpnP2sConnectionName        = "acn-vpn-connection"
vpnClientAddressPrefixes    = ["10.0.6.0/24"]


# VPN Server Configuration (Create or Use Existing)
includeVpnServerConfiguration = true
vpnServerConfigurationName    = "acn-hub-eastus2-vpn-server-config"
vpnAuthenticationTypes        = ["ADD"]
includeClientRootCertificate  = true

vpnTags = {
  environment = "Production"
  deploymentBy = "Terraform"
}

#### Route Table #######

routeTableName = "acn-hub-eastus2-rt"

routeTableBgpRoutePropagationEnabled = true

routeTableRoutes = [
  {
    name           = "to-vnet-local"
    address_prefix = "10.0.0.0/16"
    next_hop_type  = "VnetLocal"
  },
  {
    name           = "to-internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }
]
routeTableTags = {
  environment = "Production"
  deploymentBy = "Terraform"
}