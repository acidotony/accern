variable "subscription_ids" {
  description = "The list of subscription IDs to assign the policy"
  type        = list(string)
}

variable "management_group_id" {
  description = "The management group ID to assign the policy"
  type        = string
}