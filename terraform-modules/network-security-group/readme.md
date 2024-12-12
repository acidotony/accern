
# Terraform Network Security Group (NSG) Module

This Terraform module creates an Azure Network Security Group (NSG) and configures security rules dynamically.

## Features

- **Network Security Group Deployment**: Creates an NSG in the specified location and resource group.
- **Dynamic Security Rules**: Supports a flexible list of security rules for precise network access control.
- **Outputs**: Provides the NSG ID and name for reference.

## Usage Example

To use this module in your Terraform configuration, use the following syntax:

```hcl
module "network_security_group" {
  source              = "../modules/network_security_group"  // Adjust the source location based on your directory structure
  name                = "my-nsg"
  location            = "East US"
  resource_group_name = "my-resource-group"
  rules = [
    {
      name                       = "AllowSSH"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "AllowHTTP"
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}
```

## Required Inputs

The following input variables are required:

| Name                  | Description                                           | Type           | Default | Required |
|-----------------------|-------------------------------------------------------|----------------|---------|:--------:|
| `name`               | The name of the Network Security Group.               | string         | n/a     | yes      |
| `location`           | The location/region for the Network Security Group.   | string         | n/a     | yes      |
| `resource_group_name` | The name of the resource group for the NSG.           | string         | n/a     | yes      |
| `rules`              | A list of security rules to configure for the NSG.    | list(object)   | n/a     | yes      |

## Outputs

| Name      | Description                              |
|-----------|------------------------------------------|
| `id`      | The resource ID of the Network Security Group. |
| `name`    | The name of the Network Security Group.  |

## Providers

| Name     | Version  |
|----------|----------|
| azurerm  | >= 4.11.0 |

## Features

- **Customizable Security Rules**: Allows configuring rules for inbound and outbound traffic with granular control.
- **Dynamic Rule Application**: Supports dynamic creation of rules based on input.
- **Comprehensive Outputs**: Provides the NSG ID and name for integration with other modules.
