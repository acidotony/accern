
# Terraform Require Tags Policy Module

This Terraform module creates custom policies to enforce the presence of specific tags on resource groups, except those starting with `MC_`. These policies can be assigned at both subscription and management group levels.

## Features

- **Policy Definition for Subscriptions**: Defines a custom policy to enforce tags on resource groups within specific subscriptions.
- **Policy Definition for Management Groups**: Defines a custom policy to enforce tags on resource groups within specific management groups.
- **Policy Assignment**: Assigns the custom policies to subscriptions or management groups.
- **Dynamic Tag Enforcement**: Allows defining a list of tags to enforce on resource groups.
- **Outputs**: Provides details of the custom policies and their assignments.

## Usage Example

To use this module in your Terraform configuration, use the following syntax:

```hcl
module "require_tags_policy" {
  source               = "../modules/require_tags_policy"  // Adjust the source location based on your directory structure
  subscription_ids     = ["subscription-id-1", "subscription-id-2"]
  management_group_ids = ["management-group-id-1", "management-group-id-2"]
  tags                 = ["Environment", "Owner"]
}
```

## Required Inputs

The following input variables are required:

| Name                  | Description                                           | Type           | Default | Required |
|-----------------------|-------------------------------------------------------|----------------|---------|:--------:|
| `tags`               | List of tags to enforce on resource groups.           | list(string)   | `[]`    | yes      |
| `subscription_ids`    | List of subscription IDs to assign the policy.        | list(string)   | `[]`    | yes      |
| `management_group_ids`| List of management group IDs to assign the policy.    | list(string)   | `[]`    | yes      |

## Outputs

| Name                                   | Description                                                      |
|----------------------------------------|------------------------------------------------------------------|
| `subscription_policy_definitions`      | Custom policy definitions created for subscriptions.             |
| `management_group_policy_definitions`  | Custom policy definitions created for management groups.         |
| `subscription_policy_assignments`      | Custom policy assignments created for subscriptions.             |
| `management_group_policy_assignments`  | Custom policy assignments created for management groups.         |

## Providers

| Name     | Version  |
|----------|----------|
| azurerm  | >= 4.11.0 |

## Features

- **Customizable Policy Definitions**: Define policies dynamically based on subscription or management group scope.
- **Flexible Tag Enforcement**: Enforce tags on resource groups while excluding those starting with `MC_`.
- **Comprehensive Outputs**: Retrieve details of the policy definitions and assignments for monitoring and auditing.
