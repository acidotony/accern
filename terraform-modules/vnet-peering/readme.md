
# Terraform Virtual Network Peering Module

This Terraform module creates peering between two Azure Virtual Networks (VNet), enabling communication between a main VNet and a hub VNet. It supports optional configurations for creating new VNets or using existing ones.

## Features

- **VNet Peering Creation**: Establishes bidirectional peering between main and hub VNets.
- **Flexible VNet Configuration**: Supports creating new VNets or using existing ones.
- **Traffic Permissions**: Allows virtual network access and forwarded traffic between peer networks.
- **Outputs**: Provides the resource IDs of the created VNet peerings.

## Usage Example

To use this module in your Terraform configuration, use the following syntax:

```hcl
module "vnet_peering" {
  source                   = "../modules/vnet_peering"  // Adjust the source location based on your directory structure
  create_hub               = true
  use_existing_hub         = false
  vnet_main_name           = "main-vnet"
  vnet_hub_name            = "hub-vnet"
  resource_group_name_main = "main-resource-group"
  resource_group_name_hub  = "hub-resource-group"
  virtual_network_name_main = "main-vnet-name"
  virtual_network_name_hub  = "hub-vnet-name"
  remote_virtual_network_id_hub = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/hub-rg/providers/Microsoft.Network/virtualNetworks/hub-vnet"
  remote_virtual_network_id_main = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/main-rg/providers/Microsoft.Network/virtualNetworks/main-vnet"
}
```

## Required Inputs

The following input variables are required:

| Name                           | Description                                         | Type   | Default | Required |
|--------------------------------|-----------------------------------------------------|--------|---------|:--------:|
| `create_hub`                   | Boolean to create Hub VNet.                        | bool   | n/a     | yes      |
| `vnet_main_name`               | Name of the main VNet.                             | string | n/a     | yes      |
| `vnet_hub_name`                | Name of the hub VNet.                              | string | n/a     | yes      |
| `resource_group_name_main`     | Resource group name of the main VNet.              | string | n/a     | yes      |
| `resource_group_name_hub`      | Resource group name of the hub VNet.               | string | n/a     | yes      |
| `virtual_network_name_main`    | Virtual Network name for main VNet.                | string | n/a     | yes      |
| `virtual_network_name_hub`     | Virtual Network name for hub VNet.                 | string | n/a     | yes      |
| `remote_virtual_network_id_hub`| Remote Virtual Network ID for hub VNet.            | string | n/a     | yes      |
| `remote_virtual_network_id_main`| Remote Virtual Network ID for main VNet.          | string | n/a     | yes      |

## Optional Inputs

| Name                           | Description                                         | Type   | Default |
|--------------------------------|-----------------------------------------------------|--------|---------|
| `create_vnet`                  | Boolean to create VNet Main.                       | bool   | `false` |
| `use_existing_hub`             | Boolean to use existing Hub VNet.                  | bool   | `false` |

## Outputs

| Name                   | Description                                      |
|------------------------|--------------------------------------------------|
| `main_to_hub_peering_id` | The resource ID of the VNet peering from Main to Hub. |
| `hub_to_main_peering_id` | The resource ID of the VNet peering from Hub to Main. |

## Providers

| Name     | Version  |
|----------|----------|
| azurerm  | >= 4.11.0 |

## Features

- **Bidirectional Peering**: Establishes secure communication between main and hub VNets.
- **Customizable Setup**: Configure VNets as new or existing resources.
- **Comprehensive Outputs**: Provides VNet peering IDs for integration with other resources.
