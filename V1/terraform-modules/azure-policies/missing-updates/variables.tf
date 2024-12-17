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

variable "vm_locations" {
  type        = list(string)
  description = "Machines locations"
  default     = []
}

variable "tag_values" {
  type        = map(string)
  description = "Tags on machines"
  default     = {}
}

variable "os_type" {
  type        = string
  description = "OS type"
  default     = "Windows"
}

variable "tag_operator" {
  type        = string
  description = "Tag operator"
  default     = "Any"
}

variable "assessment_mode" {
  type        = string
  description = "Assessment mode"
  default     = "AutomaticByPlatform"
}
