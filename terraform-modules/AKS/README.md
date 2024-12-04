# terraform-azurerm-aks

"This module deploys an [Azure Kubernetes services](https://learn.microsoft.com/en-us/azure/aks/concepts-clusters-workloads#what-is-kubernetes) (AKS) cluster in Azure, allowing for scalable and efficient container orchestration with Kubernetes."

## Features

- Deployment of Azure Kubernetes Service (AKS) with customizable node pools.
- Configuration options for network plugins, policies, and role-based access control with Azure AD integration.
- Support for both manual scaling and autoscaling of node pools.
- Integration with Azure Container Registry if specified.



Ensure your environment variables are set as shown:

```shell
export ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
export ARM_TENANT_ID="<azure_subscription_tenant_id>"
export ARM_CLIENT_ID="<service_principal_appid>"
export ARM_CLIENT_SECRET="<service_principal_password>"
```

On Windows Powershell:

```powershell
$env:ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
$env:ARM_TENANT_ID="<azure_subscription_tenant_id>"
$env:ARM_CLIENT_ID="<service_principal_appid>"
$env:ARM_CLIENT_SECRET="<service_principal_password>"
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3 |
| azurerm | >= 3.0, < 4.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 3.0, < 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| azurerm_kubernetes_cluster.aks |	resource |
| azurerm_kubernetes_cluster_node_pool.additional |	resource |

## Inputs

| Name                               | Description                                                                                      | Type         | Default   | Required |
|------------------------------------|--------------------------------------------------------------------------------------------------|--------------|-----------|:--------:|
| `aks_name`                         | The name of the AKS cluster.                                                                     | `string`     | n/a       | yes      |
| `location`                         | The Azure region where the AKS cluster will be created.                                          | `string`     | n/a       | yes      |
| `resource_group_name`              | The name of the resource group in which to create the AKS cluster.                               | `string`     | n/a       | yes      |
| `subnet_name`                      | The name of the subnet where the AKS cluster will be deployed.                                   | `string`     | n/a       | yes      |
| `nodepool_name`                    | The name of the default node pool.                                                               | `string`     | n/a       | yes      |
| `nodepool_sku`                     | The SKU (size) of the VMs in the default node pool.                                              | `string`     | n/a       | yes      |
| `node_count`                       | The number of nodes in the default node pool, used if auto-scaling is disabled.                  | `number`     | `1`       | no       |
| `kubernetes_version`               | Version of Kubernetes to use for the AKS cluster.                                                | `string`     | n/a       | yes      |
| `network_plugin`                   | Network plugin to use for networking.                                                            | `string`     | n/a       | yes      |
| `network_policy`                   | Network policy to use for controlling traffic between pods.                                      | `string`     | n/a       | yes      |
| `load_balancer_sku`                | Specifies the SKU of the Load Balancer used for the AKS cluster.                                 | `string`     | n/a       | yes      |
| `enable_auto_scaling`              | Boolean flag to specify whether auto-scaling is enabled for node pools.                          | `bool`       | `false`   | no       |
| `node_min_count`                   | Minimum number of nodes in the node pool, applicable if auto-scaling is enabled.                 | `number`     | `1`       | no       |
| `node_max_count`                   | Maximum number of nodes in the node pool, applicable if auto-scaling is enabled.                 | `number`     | `2`       | no       |
| `node_max_pods`                    | Maximum number of pods that can run on an agent node.                                            | `number`     | `100`     | no       |
| `role_based_access_control_enabled`| Enable Role Based Access Control.                                                                | `bool`       | `false`   | no       |
| `rbac_aad`                         | Indicates if Azure Active Directory integration is enabled for RBAC.                             | `bool`       | `false`   | no       |
| `rbac_aad_managed`                 | Indicates if the Azure AD integration is managed by Azure.                                       | `bool`       | `false`   | no       |
| `rbac_aad_admin_group_object_ids`  | List of Azure AD group object IDs that will have admin role on the cluster.                      | `list(string)` | `[]`     | no       |
| `rbac_aad_azure_rbac_enabled`      | Indicates if Azure RBAC for Kubernetes authorization is enabled.                                 | `bool`       | `false`   | no       |
| `rbac_aad_tenant_id`               | The Tenant ID used for Azure Active Directory Application.                                       | `string`     | `null`    | no       |
| `local_account_disabled`           | Indicates if local accounts on the AKS cluster should be disabled.                               | `bool`       | `false`   | no       |



## Outputs

| Name | Description |
|------|-------------|
| cluster_id |	The unique identifier of the AKS cluster |
| kube_config	| Kubeconfig file contents for connecting to the Kubernetes cluster |
| node_resource_group |	The name of the resource group which contains the nodes of the AKS cluster |
| api_server_address |	The URL to the Kubernetes API server |
| identity_principal_id	| The principal ID of the system-assigned identity used by the AKS cluster |

## Example Variables 
``` Bash
# Resource Group and Location
resource_group_name = "Optimus-aks-RG"
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
subnet_name             = "default"
enable_auto_scaling     = true
node_min_count          = 1
node_max_count          = 5
node_max_pods           = 110
local_account_disabled  = false

# Subnet ID
subnet_ids = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/vnet-rg/providers/Microsoft.Network/virtualNetworks/vnet-name/subnets/default"

# Additional Node Pools
additional_node_pools = [
  {
    name        = "extraPool1"
    sku         = "Standard_DS3_v2"
    count       = 2
    subnet_name = "extrasubnet1"
  }
]

# RBAC and Azure AD Integration
role_based_access_control_enabled = true
rbac_aad                         = true
rbac_aad_managed                 = true
rbac_aad_admin_group_object_ids  = ["group1-id", "group2-id"]
rbac_aad_azure_rbac_enabled      = true
rbac_aad_tenant_id               = "tenant-id-value"

# Tags for Resources
tags = {
  "Environment" = "Development"
  "Project"     = "Optimus Project"
}

# Availability Zones for Nodes
node_availability_zones = ["1", "2", "3"]
```

