
variable "length" {
  description = "Length of the random string"
  type        = number
  default     = 8
}

variable "special" {
  description = "Include special characters in the random string"
  type        = bool
  default     = false
}

variable "upper" {
  description = "Include uppercase characters in the random string"
  type        = bool
  default     = false
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Location of the resources"
  type        = string
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
}



### Network Variables ####
variable "address_space_spoke" {
  description = "Address space for the spoke virtual network"
  type        = list(string)
}


variable "subnets_spoke" {
  description = "Subnets for the spoke virtual network"
  type        = map(object({
    address_prefixes        = list(string)
    service_endpoints       = list(string)
    delegation              = bool
    delegation_name         = string
    service_delegation_name = string
    actions                 = list(string)
  }))
}

variable "nsgs" {
  description = "A map of NSGs with their respective rules"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
}

variable "vnet_spoke_name" {
  description = "The name of the spoke virtual network"
  type        = string
}


# variable "address_space" {
#   description = "Address space for the virtual network"
#   type        = list(string)
# }

variable "subnets" {
  description = "Subnets for the virtual network"
  type        = map(object({
    address_prefixes     = list(string)
    service_endpoints    = list(string)
    delegation           = bool
    delegation_name      = string
    service_delegation_name = string
    actions              = list(string)
  }))
  default = {
    subnet1 = {
      address_prefixes     = ["10.0.1.0/24"]
      service_endpoints    = []
      delegation           = false
      delegation_name      = ""
      service_delegation_name = ""
      actions              = []
    }
    subnet2 = {
      address_prefixes     = ["10.0.2.0/24"]
      service_endpoints    = []
      delegation           = false
      delegation_name      = ""
      service_delegation_name = ""
      actions              = []
    }
  }
}


variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "object_id" {
  description = "Azure Object ID"
  type        = string
}

variable "storage_account_name" {
  description = "The storage account name"
  type        = string
}

variable "key_vault_name" {
  description = "the storage account name"
  type        = string
}



# variable "dns_zone_name" {
#   description = "Name of the DNS zone"
#   type        = string
# }

# variable "dns_records" {
#   description = "DNS records for the DNS zone"
#   type        = map(object({
#     name = string
#     type    = string
#     ttl     = number
#     records = list(string)
#   }))
# }

### ACR Variables ####
variable "acr_name" {
  description = "Specifies the name of the Container Registry. Must be unique across all Azure resources."
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

variable "acr_tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}




### AKS Variables ###
variable "aks_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "The Kubernetes version for the AKS cluster"
  type        = string
}

variable "local_account_disabled" {
  description = "Disable local accounts on the AKS cluster"
  type        = bool
}

variable "subnet_spoke_aks_name" {
  description = "The subnet name for the AKS cluster"
  type        = string
}

variable "role_based_access_control_enabled" {
  description = "Enable Role-Based Access Control for AKS"
  type        = bool
}

variable "aks_tags" {
  description = "Tags for the AKS cluster"
  type        = map(string)
}

variable "default_nodepool_name" {
  description = "The name of the default node pool"
  type        = string
}

variable "default_nodepool_sku" {
  description = "The VM SKU for the default node pool"
  type        = string

  validation {
    condition     = contains(local.valid_nodepool_skus, var.default_nodepool_sku)
    error_message = "Invalid nodepool SKU. Please use a valid SKU with zone redundancy."
  }
}

variable "default_auto_scaling_enabled" {
  description = "Enable autoscaling for the default node pool"
  type        = bool
}

variable "default_node_min_count" {
  description = "Minimum number of nodes in the default node pool"
  type        = number
}

variable "default_node_max_count" {
  description = "Maximum number of nodes in the default node pool"
  type        = number
}

variable "default_node_max_pods" {
  description = "Maximum pods per node"
  type        = number
}

variable "default_node_count" {
  description = "The initial node count if autoscaling is disabled"
  type        = number
}

variable "pod_cidr" {
  description = "The CIDR range for pods."
  type        = string
}

variable "identity_type" {
  description = "The type of identity for the AKS cluster"
  type        = string
}

variable "network_plugin" {
  description = "The network plugin for the AKS cluster"
  type        = string
}

variable "network_plugin_mode" {
  description = "The network plugin mode for the AKS cluster"
  type        = string
}

variable "network_policy" {
  description = "The network policy for the AKS cluster"
  type        = string
}

variable "network_type" {
  description = "The network type for the AKS cluster"
  type        = string
}

variable "load_balancer_sku" {
  description = "The SKU of the load balancer for the AKS cluster"
  type        = string
}

variable "rbac_aad" {
  description = "Enable Azure Active Directory integration for RBAC"
  type        = bool
}

variable "rbac_aad_managed" {
  description = "Enable managed Azure AD integration for RBAC"
  type        = bool
}

variable "rbac_aad_admin_group_object_ids" {
  description = "Admin group object IDs for Azure AD RBAC"
  type        = list(string)
}

variable "rbac_aad_azure_rbac_enabled" {
  description = "Enable Azure RBAC for AKS"
  type        = bool
}

variable "rbac_aad_tenant_id" {
  description = "Tenant ID for Azure AD RBAC"
  type        = string
}

variable "additional_node_pools" {
  description = "A list of additional node pool objects, each specifying name, sku, count, subnet_name, zones, and autoscaling configurations."
  type = list(object({
    name               = string
    sku                = string
    count              = number
    subnet_name        = string
    auto_scaling_enabled = bool
    zones              = list(string)
    min_count          = number
    max_count          = number
    labels = map(string)
    mode = string
  }))
  default = []

  validation {
    condition = alltrue([for node_pool in var.additional_node_pools : contains(local.valid_nodepool_skus, node_pool.sku)])
    error_message = "Invalid SKU in additional_node_pools. Please use valid SKUs with zone redundancy."
  }
}

variable "default_node_pool_zones" {
  description = "List of availability zones for the default node pool"
  type        = list(string)
  default     = []
}
variable "default_node_labels" {
  description = "Default Node Pool Labels"
  type= map(string)
  default = {}
  
}


