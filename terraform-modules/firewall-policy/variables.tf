# variables.tf

variable "name" {
  description = "The name of the Firewall Policy."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the Firewall Policy will be created."
  type        = string
}

variable "location" {
  description = "The location/region of the Firewall Policy."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "sku_tier" {
  description = "The SKU Tier of the Firewall Policy (e.g., Standard or Premium)."
  type        = string
}

variable "threat_intel_mode" {
  description = "Specifies the Threat Intel Mode for the Firewall Policy (e.g., Alert, Deny, or Off)."
  type        = string
}

variable "identity_ids" {
  description = "List of User Assigned Managed Identity IDs to attach to the Firewall Policy."
  type        = list(string)
  default     = []
}

variable "intrusion_detection_mode" {
  description = "Specifies the intrusion detection mode (e.g., Alert, Deny, or Off)."
  type        = string
}

variable "signature_overrides" {
  description = "Specifies the list of intrusion detection signature overrides."
  type        = list(object({
    id         = string
    action     = string
    description = string
  }))
  default = []
}

variable "bypass_traffic" {
  description = "Specifies traffic bypass rules for intrusion detection."
  type        = list(object({
    name       = string
    description = string
    source      = list(string)
    destination = list(string)
  }))
  default = []
}
