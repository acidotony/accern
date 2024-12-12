
# Terraform NICs No Public IP Policy Assignment Module

This Terraform module assigns a policy to ensure that network interfaces do not have public IP addresses. The policy can be assigned at both the subscription and management group levels.

## Features

- **Policy Assignment to Subscriptions**: Assigns the "Network interfaces should not have public IPs" policy to multiple Azure subscriptions.
- **Policy Assignment to Management Groups**: Optionally assigns the policy to a management group.
- **Outputs**: Provides details of the policy assignments for both subscriptions and management groups.

## Usage Example

To use this module in your Terraform configuration, use the following syntax:

```hcl
module "nics_no_pip_policy_assignment" {
  source               = "../modules/nics_no_pip_policy_assignment"  // Adjust the source location based on your directory structure
  subscription_ids     = ["subscription-id-1", "subscription-id-2"]
  management_group_id  = "management-group-id"
}
```

## Required Inputs

The following input variables are required:

| Name                  | Description                                           | Type           | Default | Required |
|-----------------------|-------------------------------------------------------|----------------|---------|:--------:|
| `subscription_ids`    | The list of subscription IDs to assign the policy.    | list(string)   | n/a     | yes      |
| `management_group_id` | The management group ID to assign the policy.         | string         | n/a     | yes      |

## Outputs

| Name                               | Description                                                      |
|------------------------------------|------------------------------------------------------------------|
| `subscription_policy_assignments`  | Policy assignments for ensuring network interfaces do not have public IPs at the subscription level. |
| `management_group_policy_assignment` | Policy assignment for ensuring network interfaces do not have public IPs at the management group level.|

## Providers

| Name     | Version  |
|----------|----------|
| azurerm  | >= 4.11.0 |

## Features

- **Dynamic Assignments**: Automatically assigns policies based on input IDs for subscriptions and management groups.
- **Enforcement at Multiple Levels**: Supports policy enforcement at both the subscription and management group levels.
