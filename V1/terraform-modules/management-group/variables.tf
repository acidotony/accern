variable "management_groups" {
  description = "List of management groups to create"
  type        = list(object({
    name             = string
    display_name     = string
    parent_id        = optional(string)
    subscription_ids = optional(list(string))
  }))
}

