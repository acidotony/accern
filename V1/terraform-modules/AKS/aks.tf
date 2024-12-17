resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = replace("${var.aks_name}-dns", "_", "-")
  kubernetes_version  = var.kubernetes_version
  local_account_disabled = var.local_account_disabled
  role_based_access_control_enabled = var.role_based_access_control_enabled
  
  tags = var.tags

  default_node_pool {
    name           = var.nodepool_name
    vm_size        = var.nodepool_sku
    vnet_subnet_id = var.subnet_id
    max_pods       = var.node_max_pods
    temporary_name_for_rotation = "defaulttemp"
    zones = var.node_pool_zones
    auto_scaling_enabled = var.auto_scaling_enabled
    node_count = var.node_count
    min_count  = var.node_min_count
    max_count  = var.node_max_count
    node_labels                  = var.node_labels
    
  }

  identity {
    type = var.identity_type
  }

  network_profile {
    network_plugin       = var.network_plugin
    network_policy       = var.network_policy
    load_balancer_sku    = var.load_balancer_sku
    network_plugin_mode  = var.network_plugin_mode
    pod_cidr             = var.pod_cidr
  }

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.role_based_access_control_enabled && var.rbac_aad && var.rbac_aad_managed ? ["rbac"] : []
    content {
      admin_group_object_ids = var.rbac_aad_admin_group_object_ids
      azure_rbac_enabled     = var.rbac_aad_azure_rbac_enabled
      tenant_id              = var.rbac_aad_tenant_id
    }
  }
}


resource "azurerm_kubernetes_cluster_node_pool" "additional" {
  for_each               = { for np in var.additional_node_pools : np.name => np }
  kubernetes_cluster_id  = azurerm_kubernetes_cluster.aks.id
  name                   = substr(lower(each.value.name), 0, 12)
  vm_size                = each.value.sku
  vnet_subnet_id         = var.subnet_id
  zones                  = each.value.zones

  # Conditional logic for auto-scaling
  auto_scaling_enabled = each.value.auto_scaling_enabled
  node_count             = each.value.count
  min_count              = each.value.min_count 
  max_count              = each.value.max_count 
  mode = each.value.mode
  node_labels = each.value.labels
  depends_on = [
    azurerm_kubernetes_cluster.aks,
  ]
}

