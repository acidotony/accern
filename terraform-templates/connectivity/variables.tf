variable "resourceGroupName" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
}

variable "tags" {
  description = "Tags to assign to the resources"
  type        = map(string)
}

variable "address_space_hub" {
  description = "Address space for the hub virtual network"
  type        = list(string)
}

variable "subnets_hub" {
  description = "Subnets for the hub virtual network"
  type        = map(object({
    address_prefixes        = list(string)
    service_endpoints       = list(string)
    delegation              = bool
    delegation_name         = string
    service_delegation_name = string
    actions                 = list(string)
  }))
}

variable "vnet_hub_name" {
  description = "The name of the hub virtual network"
  type        = string
}

##### Application Gateway NSG ############

variable "applicationGatewayNsgName" {
  description = "The name of the Network Security Group for the Application Gateway subnet."
  type        = string
}

variable "applicationGatewayNsgRules" {
  description = "Security rules for the Application Gateway subnet NSG."
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}



##### Application Gateway ##########
variable "applicationGatewayCreatePublicIp" {
  description = "Determines whether to create a new public IP for the Application Gateway."
  type        = bool
  default     = true
}

variable "applicationGatewayPublicIpAddressId" {
  description = "ID of an existing public IP to use if `applicationGatewayCreatePublicIp` is set to false."
  type        = string
  default     = null
}

variable "applicationGatewayResourceGroupName" {
  description = "The name of the resource group."
  type        = string
}

variable "applicationGatewayLocation" {
  description = "The location of the resources."
  type        = string
}

variable "applicationGatewayName" {
  description = "The name of the Application Gateway."
  type        = string
}

variable "applicationGatewaySkuName" {
  description = "The SKU name of the Application Gateway."
  type        = string
}

variable "applicationGatewaySkuTier" {
  description = "The SKU tier of the Application Gateway."
  type        = string
}

variable "applicationGatewaySkuCapacity" {
  description = "The capacity of the Application Gateway SKU."
  type        = number
}

variable "applicationGatewayGatewayIpConfigName" {
  description = "The name of the gateway IP configuration."
  type        = string
}

variable "applicationGatewayFrontendPortName" {
  description = "The name of the frontend port."
  type        = string
}

variable "applicationGatewayFrontendPortNumber" {
  description = "The port number of the frontend port."
  type        = number
}

variable "applicationGatewayFrontendIpConfigurationName" {
  description = "The name of the frontend IP configuration."
  type        = string
}

variable "applicationGatewayBackendAddressPoolName" {
  description = "The name of the backend address pool."
  type        = string
}

variable "applicationGatewayHttpSettingName" {
  description = "The name of the backend HTTP settings."
  type        = string
}

variable "applicationGatewayHttpSettingCookieBasedAffinity" {
  description = "Whether cookie-based affinity is enabled for the backend HTTP settings."
  type        = string
}

variable "applicationGatewayHttpSettingPath" {
  description = "The path to be used by the backend HTTP settings."
  type        = string
}

variable "applicationGatewayHttpSettingPort" {
  description = "The port used by the backend HTTP settings."
  type        = number
}

variable "applicationGatewayHttpSettingProtocol" {
  description = "The protocol used by the backend HTTP settings."
  type        = string
}

variable "applicationGatewayHttpSettingRequestTimeout" {
  description = "The request timeout for the backend HTTP settings."
  type        = number
}

variable "applicationGatewayListenerName" {
  description = "The name of the HTTP listener."
  type        = string
}

variable "applicationGatewayListenerProtocol" {
  description = "The protocol used by the HTTP listener."
  type        = string
}

variable "applicationGatewayRequestRoutingRuleName" {
  description = "The name of the request routing rule."
  type        = string
}

variable "applicationGatewayRequestRoutingRulePriority" {
  description = "The priority of the request routing rule."
  type        = number
}

variable "applicationGatewayRequestRoutingRuleType" {
  description = "The type of the request routing rule."
  type        = string
}

variable "applicationGatewayTags" {
  description = "Tags to associate with the resources."
  type        = map(string)
  default     = {}
}

variable "applicationGatewaySubnetName" {
  description = "The Application Gateway Subnet Name"
  type        = string
}

###### VPN Point to Site variables #######
variable "vpnP2sGatewayName" {
  description = "The name of the Point-to-Site VPN Gateway."
  type        = string
}



variable "vpnP2sGatewayScaleUnit" {
  description = "The scale unit for the VPN Gateway."
  type        = number
}

variable "vpnP2sConnectionName" {
  description = "The name of the connection configuration."
  type        = string
}

variable "vpnClientAddressPrefixes" {
  description = "List of CIDR prefixes for the VPN client address pool."
  type        = list(string)
}

variable "vpnTags" {
  description = "Tags to assign to the resources"
  type        = map(string)
}

# VPN Server Configuration variables
variable "includeVpnServerConfiguration" {
  description = "Whether to create a VPN Server Configuration or use an existing one."
  type        = bool
  default     = true
}

variable "vpnServerConfigurationId" {
  description = "The ID of an existing VPN Server Configuration. Required if includeVpnServerConfiguration is false."
  type        = string
  default     = null
}

variable "vpnServerConfigurationName" {
  description = "The name of the VPN Server Configuration. Required if includeVpnServerConfiguration is true."
  type        = string
  default     = null
}

variable "vpnAuthenticationTypes" {
  description = "List of authentication types for the VPN Server Configuration."
  type        = list(string)
  default     = ["Certificate"]
}

variable "includeClientRootCertificate" {
  description = "Whether to include client root certificates in the VPN Server Configuration."
  type        = bool
  default     = false
}

variable "clientRootCertificates" {
  description = "List of client root certificates for the VPN Server Configuration. Only required if includeClientRootCertificate is true."
  type = list(object({
    name            = string
    public_cert_data = string
  }))
  default = []
}

#### Route Table #####
variable "routeTableName" {
  description = "The name of the Route Table."
  type        = string
}

variable "routeTableBgpRoutePropagationEnabled" {
  description = "Enable or disable BGP route propagation for the Route Table."
  type        = bool
  default     = true
}

variable "routeTableRoutes" {
  description = "List of routes for the Route Table."
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default = []
}

variable "routeTableTags" {
  description = "Tags to assign to the resources"
  type        = map(string)
}

##### Deployment Flags #####

variable "deploy_app_gateway" {
  description = "Flag to determine whether to deploy the Application Gateway"
  type        = bool
  default     = false
}