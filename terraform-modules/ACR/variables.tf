variable "acr_name" {
  description = "Specifies the name of the Container Registry. Must be unique across all Azure resources."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Container Registry."
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
  type        = string
}

variable "acr_sku" {
  description = "The SKU name of the Container Registry. Possible values are Basic, Standard, and Premium."
  type        = string
}

variable "admin_enabled" {
  description = "Indicates whether the admin user is enabled. Defaults to false."
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Indicates whether the container registry should be accessible over the public internet. Set to false for private mode."
  type        = bool
  default     = true
}

variable "georeplication_locations" {
  description = "A list of Azure locations where the container registry should be geo-replicated."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}




