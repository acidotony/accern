
# Terraform Resource Group Module

This Terraform module creates an Azure Resource Group with customizable tags.

## Features

- **Resource Group Creation**: Creates an Azure Resource Group in the specified location with the provided name.
- **Tag Support**: Allows attaching a flexible set of tags for resource management and tracking.
- **Outputs**: Provides the name, location, and tags of the created resource group.

## Usage Example

To use this module in your Terraform configuration, use the following syntax:

```hcl
module "resource_group" {
  source              = "../modules/resource_group"  // Adjust the source location based on your directory structure
  resource_group_name = "my-resource-group"
  location            = "East US"
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
| `resource_group_name` | The name of the Azure Resource Group.                 | string         | n/a     | yes      |
| `location`           | The location/region for the Resource Group.           | string         | n/a     | yes      |
| `tags`               | A map of tags to apply to the Resource Group.         | map(any)       | `{}`    | no       |

## Outputs

| Name                  | Description                              |
|-----------------------|------------------------------------------|
| `resource_group_name` | The name of the Azure Resource Group.    |
| `location`           | The location of the Azure Resource Group.|
| `tags`               | The tags applied to the Resource Group.  |

## Providers

| Name     | Version  |
|----------|----------|
| azurerm  | >= 4.11.0 |

## Features

- **Customizable Tags**: Allows attaching a map of tags for better resource organization.
- **Simple Deployment**: Minimal input required to create a resource group.
- **Comprehensive Outputs**: Provides key details of the created resource group.
