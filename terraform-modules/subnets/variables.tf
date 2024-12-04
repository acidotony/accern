variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "subnets" {
  description = "Subnets for the virtual network"
  type        = map(object({
    address_prefixes     = list(string)
    service_endpoints    = list(string)
    delegation           = bool
    delegation_name      = string
    service_delegation_name = string
    actions              = list(string)
  }))
}

variable "private_link_service_network_policies_enabled" {
  description = "Whether to enable network policies for Private Link Service"
  type        = bool
  default     = false
  
}