resource_group_name = "acn-product-dev-eastus01-rg"
location = "eastus2"
tags = {
  environment = "development"
  project     = "Accern"
  deploymentBy = "Terraform"
}

address_space_spoke = ["10.1.0.0/16"]

subnet_spoke_aks_name = "acn-aks-dev-eastus2-01-subnet"

subnets_spoke = {
  "acn-aks-dev-eastus2-01-subnet" = {
    address_prefixes        = ["10.1.0.0/24"]  
    service_endpoints       = []
    delegation              = false
    delegation_name         = ""
    service_delegation_name = ""
    actions                 = []
  }
}

nsgs = {
  nsg1 = {
    name                = "acn-aks-dev-eastus2-01-nsg"
    location            = "eastus2"
    resource_group_name = "acn-product-dev-eastus01-rg"
    rules = [
      {
        name                       = "Allow-HTTP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Allow-HTTPS"
        priority                   = 101
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
  
}


vnet_spoke_name = "acn-spoke-dev-eastus2-01-vnet"


key_vault_name = "acn-kv-x0"
tenant_id    = "b5db11ac-8f37-4109-a146-5d7a302f5881"
object_id    = "bfcd94a6-8868-43d3-a3ca-3727505dd1a2"

storage_account_name = "acnaksprd00"



### ACR Values ####
acr_name             = "acnprd00"
acr_sku              = "Standard"
admin_enabled        = true
public_network_access_enabled = true
georeplication_locations      = ["eastus2"]
acr_tags                           = { 
  environment = "production"
  deploymentBy = "Terraform"

   }


### AKS Values ####
aks_name                       = "acn-aks-dev-01"
kubernetes_version             = "1.30"
local_account_disabled         = true
role_based_access_control_enabled = true
aks_tags                           = { 
  environment = "development"
  deploymentBy = "Terraform"

   }
default_nodepool_name                  = "default"
default_nodepool_sku                   = "Standard_DS2_v2"
default_auto_scaling_enabled            = true
default_node_min_count                 = 1
default_node_max_count                 = 3
default_node_max_pods                  = 30
default_node_count                     = null
default_node_labels= {"env": "dev", "type": "System"}
pod_cidr= "10.245.0.0/16"
identity_type                  = "SystemAssigned"
network_plugin                 = "azure"
network_plugin_mode                 = "overlay"
network_policy                 = "azure"
network_type = "azure"
load_balancer_sku              = "standard"
rbac_aad                       = true
rbac_aad_managed               = true
rbac_aad_admin_group_object_ids = ["bfcd94a6-8868-43d3-a3ca-3727505dd1a2"]
rbac_aad_azure_rbac_enabled    = true
rbac_aad_tenant_id             = "b5db11ac-8f37-4109-a146-5d7a302f5881"
default_node_pool_zones = ["1", "2"]
additional_node_pools = [
  {
    name                = "pool1"
    subnet_name         = "acn-aks-dev-eastus2-01-subnet"
    sku                 = "Standard_DS3_v2"
    count               = null
    auto_scaling_enabled = true
    min_count           = 1
    max_count           = 3
    max_pods            = 30
    labels = {"env": "dev", "type": "poc"}
    mode = "User"
    zones                = ["1", "2"]
  },
  {
    name                = "pool2"
    subnet_name         = "acn-aks-dev-eastus2-01-subnet"
    sku                 = "Standard_DS2_v2"
    count               = 3
    auto_scaling_enabled = false
    min_count           = null
    max_count           = null
    max_pods            = 20
    labels =  {"env": "stg"}
    mode = "System"
    zones                = ["1", "2"]
  }
]



