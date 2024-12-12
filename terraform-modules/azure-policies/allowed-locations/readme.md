
# Terraform Policy Assignment Module

This Terraform module assigns an "Allowed Locations" policy to Azure subscriptions and management groups. The policy restricts the locations where resources can be deployed.

## Features

- **Policy Assignment to Subscriptions**: Assigns the "Allowed Locations" policy to multiple subscriptions.
- **Policy Assignment to Management Groups**: Optionally assigns the "Allowed Locations" policy to a management group.
- **Flexible Locations**: Supports defining a list of allowed locations.
- **Outputs**: Provides details of the policy assignments for both subscriptions and management groups.


## Usage Example

To use this module in your Terraform configuration, use the following syntax:

```hcl
module "policy_assignment" {
  source               = "../modules/policy_assignment"  // Adjust the source location based on your directory structure
  subscription_ids     = ["subscription-id-1", "subscription-id-2"]
  management_group_id  = "management-group-id"
  locations            = ["East US", "West US"]

}
```

## Required Inputs

The following input variables are required:

| Name                  | Description                                               | Type           | Default | Required |
|-----------------------|-----------------------------------------------------------|----------------|---------|:--------:|
| `subscription_ids`    | The list of subscription IDs to assign the policy.        | list(string)   | n/a     | yes      |
| `management_group_id` | The management group ID to assign the policy.             | string         | n/a     | yes      |
| `locations`           | List of allowed locations for resources.                 | list(string)   | n/a     | yes      |

## Outputs

| Name                               | Description                                                      |
|------------------------------------|------------------------------------------------------------------|
| `subscription_policy_assignments`  | Details of the policy assignments created for the subscriptions. |
| `management_group_policy_assignment` | Details of the policy assignment created for the management group. |

## Providers

| Name     | Version  |
|----------|----------|
| azurerm  | >= 4.11.0 |

## Features

- **Dynamic Assignments**: Automatically assigns policies based on input locations and subscription IDs.
- **Management Group Support**: Supports optional assignment at the management group level.

