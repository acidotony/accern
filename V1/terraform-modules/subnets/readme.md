
# Terraform Subnet Module

This Terraform module creates and manages Azure Virtual Network (VNet) subnets with support for service endpoints, delegations, and private link policies.

## Features

- **Subnet Deployment**: Creates subnets within a specified VNet and resource group.
- **Service Endpoints**: Supports configuring service endpoints for each subnet.
- **Delegations**: Enables dynamic configuration of service delegations for subnets.
- **Private Link Policies**: Configures network policies for private link services.
- **Outputs**: Provides subnet names, IDs, address prefixes, service endpoints, and delegations.

## Usage Example

To use this module in your Terraform configuration, use the following syntax:

```hcl
module "subnets" {
  source               = "../modules/subnets"  // Adjust the source location based on your directory structure
  resource_group_name  = "my-resource-group"
  virtual_network_name = "my-vnet"
  private_link_service_network_policies_enabled = false
  subnets = {
    "subnet1" = {
      address_prefixes     = ["10.0.1.0/24"]
      service_endpoints    = ["Microsoft.Storage"]
      delegation           = true
      delegation_name      = "delegation1"
      service_delegation_name = "Microsoft.ContainerInstance/containerGroups"
      actions              = ["Microsoft.Network/virtualNetworks/subnets/action"]
    },
    "subnet2" = {
      address_prefixes     = ["10.0.2.0/24"]
      service_endpoints    = []
      delegation           = false
      delegation_name      = ""
      service_delegation_name = ""
      actions              = []
    }
  }
}
```

## Required Inputs

The following input variables are required:

| Name                                 | Description                                           | Type           | Default | Required |
|--------------------------------------|-------------------------------------------------------|----------------|---------|:--------:|
| `resource_group_name`                | The name of the resource group.                      | string         | n/a     | yes      |
| `virtual_network_name`               | The name of the virtual network.                     | string         | n/a     | yes      |
| `subnets`                            | Configuration for the subnets, including address prefixes, service endpoints, and delegations. | map(object({ address_prefixes = list(string), service_endpoints = list(string), delegation = bool, delegation_name = string, service_delegation_name = string, actions = list(string) })) | n/a | yes |

## Optional Inputs

| Name                                 | Description                                           | Type           | Default |
|--------------------------------------|-------------------------------------------------------|----------------|---------|
| `private_link_service_network_policies_enabled` | Whether to enable network policies for Private Link Service. | bool | `false` |

## Outputs

| Name                        | Description                              |
|-----------------------------|------------------------------------------|
| `subnet_names`              | The names of the subnets.               |
| `subnet_ids`                | The IDs of the subnets.                 |
| `subnet_address_prefixes`   | The address prefixes of the subnets.    |
| `subnet_service_endpoints`  | The service endpoints of the subnets.   |
| `subnet_delegations`        | The delegations of the subnets.         |

## Providers

| Name     | Version  |
|----------|----------|
| azurerm  | >= 4.11.0 |

## Features

- **Flexible Subnet Configuration**: Allows dynamic configuration of multiple subnets with unique settings.
- **Service Delegations**: Supports delegating subnets for specific Azure services.
- **Comprehensive Outputs**: Provides detailed information about created subnets for integration with other resources.
