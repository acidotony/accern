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


##### Firewall Policy ######
variable "firewallPolicyName" {
  description = "The name of the Firewall Policy"
  type = string
  
}

variable "firewallPolicyTags" {
  description = "Tags to assign to the firewall policy"
  type        = map(string)
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

##### Deployment Flags #####

variable "deploy_app_gateway" {
  description = "Flag to determine whether to deploy the Application Gateway"
  type        = bool
  default     = false
}

