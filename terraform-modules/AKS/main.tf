terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.12.0"
    }
  }
}

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
    name                 = var.nodepool_name
    vm_size              = var.nodepool_sku
    vnet_subnet_id       = var.subnet_id
    auto_scaling_enabled  = var.enable_auto_scaling
    min_count            = var.node_min_count
    max_count            = var.node_max_count
    max_pods             = var.node_max_pods
    node_count       = var.enable_auto_scaling ? null : var.node_count
    
  }

  identity {
    type = var.identity_type
  }

  network_profile {
    network_plugin    = var.network_plugin
    network_policy    = var.network_policy
    load_balancer_sku = var.load_balancer_sku
    network_plugin_mode = "overlay"
    pod_cidr = "10.245.0.0/16"
  }
  
  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.role_based_access_control_enabled && var.rbac_aad && var.rbac_aad_managed ? ["rbac"] : []

    content {
      admin_group_object_ids = var.rbac_aad_admin_group_object_ids
      azure_rbac_enabled     = var.rbac_aad_azure_rbac_enabled
      #managed                = true
      tenant_id              = var.rbac_aad_tenant_id
    }
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "additional" {
  for_each            = { for np in var.additional_node_pools : np.name => np }
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  name                = substr(lower(each.value.name), 0, 12)
  vm_size             = each.value.sku
  node_count          = each.value.count
  vnet_subnet_id      = var.subnet_id
  auto_scaling_enabled = var.enable_auto_scaling
  min_count           = var.node_min_count
  max_count           = var.node_max_count
  max_pods            = var.node_max_pods

  depends_on = [
    azurerm_kubernetes_cluster.aks,
  ]
}

