# Resource Group and Location
resource_group_name = "Optimus-aks-std-sample"
location            = "East US"

# AKS Configuration
aks_name                = "optimusaks"
kubernetes_version      = "1.28"
nodepool_name           = "defaultpool"
nodepool_sku            = "Standard_DS2_v2"
node_count              = 3
identity_type           = "SystemAssigned"
network_plugin          = "azure"
network_policy          = "calico"
network_type              = "VirtualMachineScaleSets"
load_balancer_sku       = "standard"
subnet_name             = "withnonsg"
enable_auto_scaling     = true
node_min_count          = 1
node_max_count          = 5
node_max_pods           = 110
local_account_disabled  = false

# Subnet ID
subnet_id = "/subscriptions/12302488-c84e-40e3-b782-3f748417b5fb/resourceGroups/opt-vnet-main0305202401/providers/Microsoft.Network/virtualNetworks/opt-vnet-main01/subnets/withnonsg"

# Additional Node Pools
additional_node_pools = [
  {
    name        = "extraPool1"
    sku         = "Standard_DS3_v2"
    count       = 2
    subnet_name = "withnonsg"
  }
]


# RBAC and Azure AD Integration
role_based_access_control_enabled = true
rbac_aad                         = true
rbac_aad_managed                 = true
rbac_aad_admin_group_object_ids  = ["ee49ffc1-c7d1-46c7-a81b-c55099b519d6", "bfcd94a6-8868-43d3-a3ca-3727505dd1a2", "4c35c26b-a2bf-40b0-8291-c313aad6f791"] #optimus infra team
rbac_aad_azure_rbac_enabled      = true
rbac_aad_tenant_id               = ""

# Tags for Resources
tags = {
  "Environment" = "Development"
  "Project"     = "Optimus Project"
}

# Availability Zones for Nodes
node_availability_zones = ["1", "2", "3"]

