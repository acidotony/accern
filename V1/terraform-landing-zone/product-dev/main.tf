data "terraform_remote_state" "hub_networking" {
  backend = "azurerm"
  config = {
    resource_group_name  = "optimus-test-global"
    storage_account_name = "opttesttfstate220241129"
    container_name       = "accern-prd"
    key                  = "connectivity.terraform.tfstate"
  }
}

module "resource_group" {
  source              = "../../terraform-modules/resource-group"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}


module "vnet_spoke" {
  source              = "../../terraform-modules/virtual-network"
  vnet_name           = var.vnet_spoke_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space_spoke
  tags                = var.tags
  depends_on = [ module.resource_group ]
}

module "subnets_spoke" {
  source                = "../../terraform-modules/subnets"
  resource_group_name   = var.resource_group_name
  virtual_network_name  = var.vnet_spoke_name
  subnets               = var.subnets_spoke
  depends_on            = [module.vnet_spoke]
}

module "nsgs" {
  source = "../../terraform-modules/network-security-group"

  for_each = var.nsgs

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  rules               = each.value.rules
  depends_on = [ module.resource_group ]
}

module "vnet_peering" {
  source                        = "../../terraform-modules/vnet-peering"
  create_vnet                   = true
  create_hub                    = true
  use_existing_hub              = true
  vnet_main_name                = var.vnet_spoke_name
  vnet_hub_name                 = data.terraform_remote_state.hub_networking.outputs.vnet_hub_name
  resource_group_name_main      = var.resource_group_name
  resource_group_name_hub       = data.terraform_remote_state.hub_networking.outputs.resource_group_name
  virtual_network_name_main     = module.vnet_spoke.vnet_name
  virtual_network_name_hub      = data.terraform_remote_state.hub_networking.outputs.vnet_hub_name
  remote_virtual_network_id_hub = data.terraform_remote_state.hub_networking.outputs.vnet_hub_id
  remote_virtual_network_id_main= module.vnet_spoke.vnet_id
  depends_on                    = [module.vnet_spoke]  
}


module "key_vault" {
  source              = "../../terraform-modules/key-vault"
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = var.key_vault_name
  tenant_id           = var.tenant_id
  object_id           = var.object_id
  depends_on = [ module.resource_group ]
}

module "storage_account" {
  source              = "../../terraform-modules/storage-account"
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = var.storage_account_name
  tags                = var.tags
  depends_on = [ module.resource_group ]
}

module "acr" {
  source               = "../../terraform-modules/ACR"
  acr_name             = var.acr_name
  resource_group_name  = var.resource_group_name
  location             = module.resource_group.location
  acr_sku              = var.acr_sku
  admin_enabled        = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled
  georeplication_locations      = var.georeplication_locations
 
  tags = var.acr_tags

  depends_on = [
    module.resource_group,
  ]
}

module "aks" {
  source                        = "../../terraform-modules/AKS"

  aks_name                      = var.aks_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  kubernetes_version            = var.kubernetes_version
  local_account_disabled        = var.local_account_disabled
  role_based_access_control_enabled = var.role_based_access_control_enabled
  tags                          = var.aks_tags
  nodepool_name                 = var.default_nodepool_name
  nodepool_sku                  = var.default_nodepool_sku
  subnet_id                     = module.subnets_spoke.subnet_ids[var.subnet_spoke_aks_name]
  node_pool_zones       = var.default_node_pool_zones
  auto_scaling_enabled           = var.default_auto_scaling_enabled
  node_min_count                = var.default_node_min_count
  node_max_count                = var.default_node_max_count
  node_max_pods                 = var.default_node_max_pods
  node_count                    = var.default_node_count
  node_labels = var.default_node_labels
  identity_type                 = var.identity_type
  network_plugin                = var.network_plugin
  network_plugin_mode           = var.network_plugin_mode
  network_policy                = var.network_policy
  load_balancer_sku             = var.load_balancer_sku
  rbac_aad                      = var.rbac_aad
  rbac_aad_managed              = var.rbac_aad_managed
  rbac_aad_admin_group_object_ids = var.rbac_aad_admin_group_object_ids
  rbac_aad_azure_rbac_enabled   = var.rbac_aad_azure_rbac_enabled
  rbac_aad_tenant_id            = var.rbac_aad_tenant_id
  additional_node_pools         = var.additional_node_pools
  pod_cidr                      = var.pod_cidr

  # Dependencies
  depends_on                    = [module.resource_group]
}



resource "azurerm_role_assignment" "attach_acr_to_aks" {
  principal_id = module.aks.identity_principal_id
  role_definition_name             = "AcrPull"
  scope                            = module.acr.acr_id
  skip_service_principal_aad_check = true
}