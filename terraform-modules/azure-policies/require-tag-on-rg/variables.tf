variable "tags" {
  description = "List of tags to enforce on resource groups"
  type        = list(string)
  default     = []
}

variable "subscription_ids" {
  description = "List of subscription IDs to which the policy will be assigned"
  type        = list(string)
  default     = []
}

variable "management_group_ids" {
  description = "List of management group IDs to which the policy will be assigned"
  type        = list(string)
  default     = []
}