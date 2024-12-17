
# Terraform Management Group Module

This Terraform module creates Azure Management Groups and optionally associates subscriptions to them.

## Features

- **Management Group Creation**: Dynamically creates management groups based on input configuration.
- **Subscription Association**: Optionally associates subscriptions with management groups.
- **Outputs**: Provides the IDs of the created management groups.

## Providers Tested

This module has been tested with the following versions of the AzureRM provider:
- 4.13.0

## Usage Example

To use this module in your Terraform configuration, use the following syntax:

```hcl
module "management_groups" {
  source = "../modules/management_groups"  // Adjust the source location based on your directory structure

  management_groups = [
    {
      name             = "mg1"
      display_name     = "Management Group 1"
      parent_id        = "parent-mg-id"
      subscription_ids = ["subscription-id-1"]
    },
    {
      name             = "mg2"
      display_name     = "Management Group 2"
      subscription_ids = null
    }
  ]
}
```

## Required Inputs

The following input variables are required:

| Name                 | Description                                  | Type                           | Default | Required |
|----------------------|----------------------------------------------|--------------------------------|---------|:--------:|
| `management_groups`  | List of management groups to create. Each group should include `name`, `display_name`, and optional `parent_id` and `subscription_ids`. | list(object({ name = string, display_name = string, parent_id = optional(string), subscription_ids = optional(list(string)) })) | n/a     | yes      |

## Outputs

| Name                 | Description                               |
|----------------------|-------------------------------------------|
| `management_group_ids` | The IDs of the created management groups.|

## Providers

| Name     | Version  |
|----------|----------|
| azurerm  | >= 4.11.0 |

## Features

- **Flexible Management Group Configuration**: Supports parent management groups and subscription association.
- **Dynamic Subscription Association**: Allows attaching subscriptions to management groups if specified.
- **Comprehensive Outputs**: Provides the IDs of created management groups for easy reference.
