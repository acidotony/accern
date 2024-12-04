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
nodepool_name                  = "default"
nodepool_sku                   = "Standard_DS2_v2"
enable_auto_scaling            = true
node_min_count                 = 1
node_max_count                 = 5
node_max_pods                  = 30
node_count                     = 3
identity_type                  = "SystemAssigned"
network_plugin                 = "azure"
network_policy                 = "azure"
network_type = "azure"
load_balancer_sku              = "standard"
rbac_aad                       = true
rbac_aad_managed               = true
rbac_aad_admin_group_object_ids = ["bfcd94a6-8868-43d3-a3ca-3727505dd1a2"]
rbac_aad_azure_rbac_enabled    = true
rbac_aad_tenant_id             = "b5db11ac-8f37-4109-a146-5d7a302f5881"

additional_node_pools = [
  {
    name                = "pool1"
    subnet_name = "acn-aks-dev-eastus2-01-subnet"
    sku                 = "Standard_DS3_v2"
    count               = 3
    enable_auto_scaling = true
    min_count           = 2
    max_count           = 4
    max_pods            = 30
  },
  {
    name                = "pool2"
    subnet_name = "acn-aks-dev-eastus2-01-subnet"
    sku                 = "Standard_DS2_v2"
    count               = 2
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 2
    max_pods            = 20
  }
]


