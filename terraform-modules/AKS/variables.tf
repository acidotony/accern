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

variable "kubernetes_version" {
  description = "Version of Kubernetes to use for the AKS cluster."
  type        = string
}

variable "local_account_disabled" {
  description = "Disable local accounts on the AKS cluster."
  type        = bool
}

variable "role_based_access_control_enabled" {
  description = "Enable Role-Based Access Control for AKS."
  type        = bool
}

variable "tags" {
  description = "A mapping of tags to assign to the AKS cluster."
  type        = map(string)
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
  description = "The initial number of nodes in the default node pool if autoscaling is disabled."
  type        = number
}

variable "node_min_count" {
  description = "Minimum number of nodes in the default node pool."
  type        = number
}

variable "node_max_count" {
  description = "Maximum number of nodes in the default node pool."
  type        = number
}

variable "node_max_pods" {
  description = "Maximum pods per node in the default node pool."
  type        = number
}

variable "auto_scaling_enabled" {
  description = "Enable autoscaling for the default node pool"
  type        = bool
}

variable "identity_type" {
  description = "The type of identity for the AKS cluster."
  type        = string
}

variable "network_plugin" {
  description = "The network plugin for the AKS cluster."
  type        = string
}

variable "network_plugin_mode" {
  description = "The network plugin mode for the AKS cluster."
  type        = string
}

variable "network_policy" {
  description = "The network policy for the AKS cluster."
  type        = string
}

variable "load_balancer_sku" {
  description = "The SKU of the load balancer for the AKS cluster."
  type        = string
}

variable "pod_cidr" {
  description = "The CIDR range for pods."
  type        = string
}

variable "additional_node_pools" {
  description = "A list of additional node pool objects with autoscaling configurations."
  type = list(object({
    name               = string
    sku                = string
    count              = number
    subnet_name        = string
    zones              = list(string)
    auto_scaling_enabled = bool
    min_count          = number
    max_count          = number
    labels = map(string)
    mode = string
  }))
  default = []
}

variable "node_labels" {
  description = "Default Node Pool Labels"
  type= map(string)
  default = {}
  
}

variable "node_pool_zones" {
  description = "List of availability zones for the default node pool"
  type        = list(string)
  default     = []
}

variable "subnet_id" {
  description = "The ID of the subnet where the AKS cluster will be deployed."
  type        = string
}

variable "rbac_aad" {
  description = "Enable Azure Active Directory integration for RBAC."
  type        = bool
}

variable "rbac_aad_managed" {
  description = "Enable managed Azure AD integration for RBAC."
  type        = bool
}

variable "rbac_aad_admin_group_object_ids" {
  description = "Admin group object IDs for Azure AD RBAC."
  type        = list(string)
  default     = []
}

variable "rbac_aad_azure_rbac_enabled" {
  description = "Enable Azure RBAC for AKS."
  type        = bool
}

variable "rbac_aad_tenant_id" {
  description = "Tenant ID for Azure AD RBAC."
  type        = string
}
