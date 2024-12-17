variable "name" {
  description = "The name of the Network Security Group"
  type        = string
}

variable "location" {
  description = "The location of the Network Security Group"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the Network Security Group will be created"
  type        = string
}

variable "rules" {
  description = "A list of security rules for the Network Security Group"
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
