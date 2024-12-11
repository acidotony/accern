variable "policy_definition_id" {
  description = "ID of the NSG flow logs policy definition"
  type        = string
}

variable "subscription_id" {
  description = "The ID of the Azure subscription"
  type        = string
}

variable "workspace_id" {
  description = "The ID of the Log Analytics workspace"
  type        = string
}

variable "location" {
  description = "The location where the policy is assigned"
  type        = string
}