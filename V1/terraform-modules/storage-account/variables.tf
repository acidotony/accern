variable "name" {}
variable "resource_group_name" {}
variable "location" {}
variable "account_replication_type" {
  description = "Account replication type. Valid options are LRS, GRS, RAGRS, ZRS, GZRS"
  type = string
  default = "LRS"
}
variable "tags" {
  type = map(any)
}

variable "account_tier" {
  description = "The performance tier of the storage account. Valid options are Standard or Premium."
  type        = string
  default     = "Standard"
}

variable "account_kind" {
  description = "The kind of the storage account. Valid options are Storage, StorageV2, BlobStorage, etc."
  type        = string
  default     = "StorageV2"
}

variable "access_tier" {
  description = "The access tier of the storage account. Valid options are Hot or Cool. Applies only to BlobStorage and StorageV2."
  type        = string
  default     = null
}

variable "blob_change_feed_enabled" {
  description = "Enable change feed events for blobs."
  type        = bool
  default     = true
}

variable "blob_versioning_enabled" {
  description = "Enable versioning for blobs."
  type        = bool
  default     = true
}

variable "container_delete_retention_days" {
  description = "Number of days to retain deleted containers."
  type        = number
  default     = 14
}

variable "blob_delete_retention_days" {
  description = "Number of days to retain deleted blobs."
  type        = number
  default     = 14
}

variable "blob_restore_policy_days" {
  description = "Number of days for which blobs can be restored."
  type        = number
  default     = 7
}
