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

variable "vault_id" {
  type        = string
  description = "Recovery Services Vault Id"
  default     = null
}

variable "backup_policy_id" {
  type        = string
  description = "Backup Policy (of type Azure VM from a vault in the location chosen above)"
  default     = null
}

variable "name" {
  type        = string
  description = "Backup policy name"
}

variable "vault_location" {
  type        = string
  description = "Location (Specify the location of the VMs that you want to protect)"
}

variable "inclusion_tag_value" {
  type        = list(any)
  description = "Inclusion Tag Value"
}

variable "inclusion_tag_name" {
  type        = string
  description = "Inclusion Tag Name"
}

variable "effect" {
  type        = string
  description = "Effect"
  default     = "DeployIfNotExists"
}
