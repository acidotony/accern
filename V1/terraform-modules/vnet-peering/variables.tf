variable "create_vnet" {
  description = "Boolean to create VNet Main"
  type        = bool
}

variable "create_hub" {
  description = "Boolean to create Hub VNet"
  type        = bool
}

variable "use_existing_hub" {
  description = "Boolean to use existing Hub VNet"
  type        = bool
}

variable "vnet_main_name" {
  description = "Name of the main VNet"
  type        = string
}

variable "vnet_hub_name" {
  description = "Name of the hub VNet"
  type        = string
}

variable "resource_group_name_main" {
  description = "Resource group name of the main VNet"
  type        = string
}

variable "resource_group_name_hub" {
  description = "Resource group name of the hub VNet"
  type        = string
}

variable "virtual_network_name_main" {
  description = "Virtual Network name for main VNet"
  type        = string
}

variable "virtual_network_name_hub" {
  description = "Virtual Network name for hub VNet"
  type        = string
}

variable "remote_virtual_network_id_hub" {
  description = "Remote Virtual Network ID for hub VNet"
  type        = string
}

variable "remote_virtual_network_id_main" {
  description = "Remote Virtual Network ID for main VNet"
  type        = string
}
