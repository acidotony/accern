variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "address_space" {
  description = "The address space of the virtual network"
  type        = list(string)
}

variable "tags" {
  description = "Tags to assign to the virtual network"
  type        = map(string)
}

