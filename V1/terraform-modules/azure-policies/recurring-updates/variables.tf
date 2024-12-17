variable "subscription_id" {
  type        = string
  description = "Subscription Id"
  default     = null  
}

variable "location" {
  type        = string
  description = "Location"
  default     = null  
}

variable "mnt_config_resource_id" {
  type        = string
  description = "Maintenance Configuration ARM ID"
  default     = null  
}

variable "tag_values" {
  type        = list(map(string))
  description = "Tags on machines"
}

variable "effect" {
  type        = string
  description = "Effect"
}

variable "resource_groups" {
  type        = list(string)
  description = "Resource groups"
}

variable "tag_operator" {
  type        = string
  description = "Tags operator"
}

variable "vm_locations" {
  type        = list(string)
  description = "Machines locations"
}

variable "operating_system_types" {
  type        = list(string)
  description = "Operating System types"
}
