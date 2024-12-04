variable "aks_name" {
  description = "The name of the AKS cluster."
  type        = string
}

variable "location" {
  description = "The Azure region where the AKS cluster will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the AKS cluster."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the AKS cluster will be located."
  type        = string
}

variable "nodepool_name" {
  description = "The name of the default node pool."
  type        = string
}

variable "nodepool_sku" {
  description = "The SKU (size) of the VMs in the default node pool."
  type        = string
}

variable "node_count" {
  description = "The number of nodes in the default node pool."
  type        = number
  default     = 1
}

variable "additional_node_pools" {
  description = "A list of additional node pool objects, each specifying name, sku, count, and subnet_name."
  type = list(object({
    name        = string
    sku         = string
    count       = number
    subnet_name = string
  }))
  default = []
}

variable "subnet_name" {
  description = "The name of the subnet where the AKS cluster will be deployed."
  type        = string
}

variable "kubernetes_version" {
  description = "Version of Kubernetes to use for the AKS cluster."
  type        = string
}

variable "network_type" {
  description = "Type of network to be used for AKS nodes."
  type        = string
}

variable "network_plugin" {
  description = "Network plugin to use for networking."
  type        = string
}

variable "network_policy" {
  description = "Network policy to use for controlling traffic between pods."
  type        = string
}

variable "load_balancer_sku" {
  description = "Specifies the SKU of the Load Balancer used for the AKS cluster."
  type        = string
}

variable "aad_admin_group_object_ids" {
  description = "List of Azure AD group object IDs that will have admin role of the cluster."
  type        = list(string)
  default     = []
}

variable "identity_type" {
  description = "Type of identity used for the AKS cluster."
  type        = string
  default     = "SystemAssigned"
}


variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "sku_tier" {
  description = "Type of identity used for the AKS cluster."
  type        = string
  default     = "Standard"
}

variable "node_availability_zones" {
  description = "A list of availability zones for the agent nodes."
  type        = list(string)
  default     = ["1", "2"]
}

variable "node_max_count" {
  description = "Maximum number of nodes in the node pool."
  type        = number
  default     = 2
}

variable "node_max_pods" {
  description = "Maximum number of pods that can run on an agent node."
  type        = number
  default     = 100
}

variable "node_min_count" {
  description = "Minimum number of nodes in the node pool."
  type        = number
  default     = 1
}


variable "enable_auto_scaling" {
  description = "Boolean flag to specify whether autoscaling is Enabled."
  type        = bool
}

# variable "subnet_ids" {
#   description = "Map of subnet names to their IDs"
#   type        = map(string)
# }

variable "role_based_access_control_enabled" {
  type        = bool
  description = "Enable Role Based Access Control."
}

variable "rbac_aad" {
  type        = bool
  description = "(Optional) Is Azure Active Directory integration enabled?"
  nullable    = false
}

variable "rbac_aad_managed" {
  type        = bool
  description = "Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration."
  nullable    = false
}

variable "rbac_aad_admin_group_object_ids" {
  type        = list(string)
  default     = null
  description = "Object ID of groups with admin access."
}

variable "rbac_aad_azure_rbac_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Is Role Based Access Control based on Azure AD enabled?"
}

variable "rbac_aad_tenant_id" {
  type        = string
  default     = null
  description = "(Optional) The Tenant ID used for Azure Active Directory Application. If this isn't specified the Tenant ID of the current Subscription is used."
}

variable "local_account_disabled" {
  type        = bool
  description = "AKS cluster local accounts will be disabled"
}


 