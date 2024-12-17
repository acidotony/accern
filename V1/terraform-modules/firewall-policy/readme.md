
# Terraform Azure Firewall Policy Module

This Terraform module deploys an Azure Firewall Policy, which provides centralized configuration and management of firewall rules and policies across multiple Azure Firewall instances.

## Features

- **Firewall Policy Deployment**: Creates an Azure Firewall Policy with a specified name, location, and resource group.
- **Tags**: Allows tagging for cost tracking and resource management.

## Usage Example

To use this module in your Terraform configuration, use the following syntax:

```hcl
module "azure_firewall_policy" {
  source              = "../modules/firewall_policy"  // Adjust the source location based on your directory structure
  name                = "myFirewallPolicy"
  resource_group_name = "myResourceGroup"
  location            = "East US"
  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
```

## Required Inputs

The following input variables are required:

| Name                  | Description                                         | Type   | Default | Required |
|-----------------------|-----------------------------------------------------|--------|---------|:--------:|
| `name`               | The name of the Web Application Firewall Policy.    | string | n/a     | yes      |
| `resource_group_name` | The name of the resource group.                     | string | n/a     | yes      |
| `location`            | The location of the Web Application Firewall Policy. | string | n/a     | yes      |

## Optional Inputs

| Name  | Description                          | Type        | Default | Required |
|-------|--------------------------------------|-------------|---------|:--------:|
| `tags`| A mapping of tags to assign to the resource. | map(string) | `{}`    | no       |

## Outputs

| Name            | Description                                      |
|------------------|--------------------------------------------------|
| `waf_policy_id` | The ID of the Web Application Firewall Policy.   |

## Providers

| Name     | Version |
|----------|---------|
| azurerm  | >= 4.0  |
