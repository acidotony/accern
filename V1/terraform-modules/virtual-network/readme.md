
# Terraform Virtual Network Module

This Terraform module creates an Azure Virtual Network (VNet) with customizable address spaces and tags.

## Features

- **Virtual Network Deployment**: Creates a virtual network in the specified location and resource group.
- **Custom Address Space**: Supports defining multiple address spaces for the virtual network.
- **Tag Support**: Allows attaching tags to the virtual network for better resource organization.
- **Outputs**: Provides the VNet ID, name, and address space.

## Usage Example

To use this module in your Terraform configuration, use the following syntax:

```hcl
module "virtual_network" {
  source              = "../modules/virtual_network"  // Adjust the source location based on your directory structure
  vnet_name           = "my-vnet"
  location            = "East US"
  resource_group_name = "my-resource-group"
  address_space       = ["10.0.0.0/16"]
  tags = {
    Environment = "Development"
    Owner       = "Admin"
  }
}
```

## Required Inputs

The following input variables are required:

| Name                  | Description                                           | Type           | Default | Required |
|-----------------------|-------------------------------------------------------|----------------|---------|:--------:|
| `vnet_name`           | The name of the virtual network.                     | string         | n/a     | yes      |
| `location`           | The location/region for the virtual network.          | string         | n/a     | yes      |
| `resource_group_name` | The name of the resource group for the virtual network.| string         | n/a     | yes      |
| `address_space`       | The address space of the virtual network.             | list(string)   | n/a     | yes      |

## Optional Inputs

| Name                  | Description                                           | Type           | Default |
|-----------------------|-------------------------------------------------------|----------------|---------|
| `tags`               | Tags to assign to the virtual network.                | map(string)    | `{}`    |

## Outputs

| Name           | Description                              |
|----------------|------------------------------------------|
| `vnet_id`      | The resource ID of the virtual network.  |
| `vnet_name`    | The name of the virtual network.         |
| `address_space`| The address space of the virtual network.|

## Providers

| Name     | Version  |
|----------|----------|
| azurerm  | >= 4.11.0 |

## Features

- **Customizable Address Space**: Supports defining multiple address spaces for the virtual network.
- **Simple Deployment**: Minimal inputs required for creating a virtual network.
- **Comprehensive Outputs**: Provides key details of the created virtual network for integration with other modules.
