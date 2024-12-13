
# AKS Terraform Module Documentation

This document provides guidance on using the AKS Terraform module to deploy and manage Azure Kubernetes Service (AKS) clusters, including configurations for autoscaling, role-based access control (RBAC), and additional node pools.

---

## Variables

### AKS Cluster Configuration

- **`aks_name`** *(string)*: The name of the AKS cluster.
  - Example: `my-aks-cluster`
- **`location`** *(string)*: Azure region where the AKS cluster will be created.
  - Example: `East US`
- **`resource_group_name`** *(string)*: Name of the resource group for the AKS cluster.
  - Example: `my-resource-group`
- **`kubernetes_version`** *(string)*: Version of Kubernetes to use.
  - Example: `1.25.6`
- **`local_account_disabled`** *(bool)*: Disables local accounts on the cluster.
  - Default: `false`

### Role-Based Access Control (RBAC)

- **`role_based_access_control_enabled`** *(bool)*: Enables RBAC.
  - Default: `true`
- **`rbac_aad`** *(bool)*: Enables Azure Active Directory integration.
  - Default: `false`
- **`rbac_aad_managed`** *(bool)*: Enables managed Azure AD integration.
  - Default: `false`
- **`rbac_aad_admin_group_object_ids`** *(list(string))*: List of AAD group object IDs with admin privileges.
  - Example: `["1234abcd-5678efgh-ijklmnop"]`
- **`rbac_aad_azure_rbac_enabled`** *(bool)*: Enables Azure RBAC for AKS.
  - Default: `false`
- **`rbac_aad_tenant_id`** *(string)*: Azure Active Directory tenant ID.

### Default Node Pool

- **`nodepool_name`** *(string)*: Name of the default node pool.
  - Example: `default`
- **`nodepool_sku`** *(string)*: SKU (size) of VMs in the default node pool.
  - Example: `Standard_DS2_v2`
- **`node_count`** *(number)*: Initial node count (when autoscaling is disabled).
  - Default: `1`
- **`node_min_count`** *(number)*: Minimum node count for autoscaling.
  - Default: `1`
- **`node_max_count`** *(number)*: Maximum node count for autoscaling.
  - Default: `5`
- **`node_max_pods`** *(number)*: Maximum pods per node.
  - Example: `110`
- **`auto_scaling_enabled`** *(bool)*: Enables autoscaling.
  - Default: `false`
- **`node_labels`** *(map(string))*: Labels assigned to nodes.
  - Default: `{}`
- **`node_pool_zones`** *(list(string))*: Availability zones for the node pool.
  - Example: `["1", "2"]`
- **`subnet_id`** *(string)*: Subnet ID for the node pool.

### Network Configuration

- **`network_plugin`** *(string)*: The network plugin (e.g., `azure` or `kubenet`).
- **`network_plugin_mode`** *(string)*: Specifies the mode for the network plugin.
  - Example: `Overlay`
- **`network_policy`** *(string)*: Network policy (e.g., `azure` or `calico`).
- **`load_balancer_sku`** *(string)*: SKU for the load balancer.
  - Default: `Standard`
- **`pod_cidr`** *(string)*: CIDR range for pods.

### Additional Node Pools

- **`additional_node_pools`** *(list(object))*: List of additional node pools.
  - **Properties:**
    - `name` *(string)*: Name of the node pool.
    - `sku` *(string)*: VM size for the node pool.
    - `count` *(number)*: Initial node count.
    - `zones` *(list(string))*: Availability zones.
    - `auto_scaling_enabled` *(bool)*: Enables autoscaling.
    - `min_count` *(number)*: Minimum node count.
    - `max_count` *(number)*: Maximum node count.
    - `labels` *(map(string))*: Node labels.
    - `mode` *(string)*: Node pool mode (e.g., `System` or `User`).

---

## Outputs

- **`cluster_id`** *(string)*: Unique identifier of the AKS cluster.
- **`kube_config`** *(sensitive)*: Kubeconfig file content for cluster access.
- **`node_resource_group`** *(string)*: Resource group containing the cluster nodes.
- **`api_server_address`** *(string)*: URL to the Kubernetes API server.
- **`identity_principal_id`** *(string)*: Principal ID of the AKS system-assigned identity.

---

## Usage

1. Define variables in a `.tfvars` file or directly in the Terraform configuration.

   Example `.tfvars` file:
   ```hcl
   aks_name                  = "my-aks-cluster"
   location                  = "East US"
   resource_group_name       = "my-resource-group"
   kubernetes_version        = "1.30.0"
   local_account_disabled    = true
   role_based_access_control_enabled = true
   nodepool_name             = "default"
   nodepool_sku              = "Standard_DS2_v2"
   node_count                = 1
   node_min_count            = 1
   node_max_count            = 3
   auto_scaling_enabled      = true
   subnet_id                 = "<subnet-id>"
   additional_node_pools = [
     {
       name = "userpool"
       sku = "Standard_DS2_v2"
       count = 2
       auto_scaling_enabled = true
       min_count = 1
       max_count = 5
       labels = {
         "env" = "production", "os"="linux"
       }
       zones = ["1", "2"]
       mode = "User"
     }
   ]
   ```

2. Initialize and apply the configuration.
   ```bash
   terraform init
   terraform apply -var-file="<your-tfvars-file>.tfvars"
   ```

3. Review the outputs for details like the cluster ID, kubeconfig, and API server URL.

---

## Notes

- Ensure the `auto_scaling_enabled` variable is set to `true` if you define `min_count` and `max_count`.
- The default node pool and additional node pools have separate configurations, so plan resource scaling accordingly.
- Use labels and tags to organize and track your Kubernetes resources effectively.

---
