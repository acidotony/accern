
# Terraform MFA Policy Assignment Module

This Terraform module assigns a policy to ensure that accounts with owner permissions on Azure resources have MFA enabled. The policy can be assigned at both the subscription and management group levels.

## Features

- **Policy Assignment to Subscriptions**: Assigns the MFA policy to multiple Azure subscriptions.
- **Policy Assignment to Management Groups**: Assigns the MFA policy to multiple management groups.
- **Customizable Effect**: Configure the policy effect as "AuditIfNotExists" or "Disabled".
- **Outputs**: Provides details of the policy assignments for both subscriptions and management groups.

## Usage Example

To use this module in your Terraform configuration, use the following syntax:

```hcl
module "mfa_policy_assignment" {
  source              = "../modules/mfa_policy_assignment"  // Adjust the source location based on your directory structure
  subscription_ids     = ["subscription-id-1", "subscription-id-2"]
  management_group_ids = ["management-group-id-1", "management-group-id-2"]
}
```

## Required Inputs

The following input variables are required:

| Name                  | Description                                           | Type           | Default | Required |
|-----------------------|-------------------------------------------------------|----------------|---------|:--------:|
| `subscription_ids`    | List of subscription IDs to which the policy will be assigned. | list(string)   | `[]`    | yes      |
| `management_group_ids`| List of management group IDs to which the policy will be assigned. | list(string) | `[]`    | yes      |

## Outputs

| Name                               | Description                                                      |
|------------------------------------|------------------------------------------------------------------|
| `subscription_policy_assignments`  | Details of the policy assignments created for subscriptions.     |
| `management_group_policy_assignments` | Details of the policy assignments created for management groups.|

## Providers

| Name     | Version  |
|----------|----------|
| azurerm  | >= 4.11.0 |

## Features

- **Dynamic Assignments**: Automatically assigns policies based on input IDs for subscriptions and management groups.
- **Customizable Policy Effect**: Allows toggling the policy effect between "AuditIfNotExists" and "Disabled".
