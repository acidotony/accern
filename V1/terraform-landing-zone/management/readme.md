
# Terraform Root Module for Management Groups and Policies

This Terraform root module deploys Azure Landing Zones, managing the hierarchy of Azure Management Groups and applying default policies for governance to ensure compliance and secure configurations.

## Features

- **Management Group Hierarchy**: Creates a structured hierarchy of management groups at multiple levels.
- **Policy Assignments**: Deploys Azure policies to enforce compliance and governance.
- **Extensibility**: Supports dynamic addition of subscriptions and policy configurations.

## Remote State Configuration

The Terraform state is stored in an Azure Storage Account. This setup ensures that the Terraform state file is securely stored and accessible by multiple team members for consistent deployments. The Storage Account must already be deployed in a different resource group, and the Terraform deployment process must have the necessary permissions to access this Storage Account.

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "<Storage Account Resource Group Name>"
    storage_account_name = "<Global Unique Storage Account Name>"
    container_name       = "accern-<environment>"
    key                  = "connectivity.terraform.tfstate"
  }
}
```

### Purpose of Remote State

1. **Team Collaboration**: Allows multiple team members to work on the same infrastructure safely by locking the state file during operations.
2. **State Integrity**: Prevents state corruption by enforcing a single source of truth.
3. **Disaster Recovery**: Ensures state files are securely backed up in Azure Storage.

## Providers Tested

This module has been tested with the following versions of the AzureRM provider:
- 4.12.0

## Components Deployed

### Management Groups

This module sets up a multi-level hierarchy for Azure Management Groups:

1. **Root Management Group**: `Accern-Root`
2. **Level 1 Management Groups**:
   - `acn-landingzones`
   - `acn-platform`
   - `acn-sandboxes`
   - `acn-decommissioned`
3. **Level 2 Management Groups**:
   - `acn-platform-services`
   - `acn-production`
   - `acn-development`

### Policies Applied

1. **MFA for Owners**: Enforces multi-factor authentication for owner accounts.
2. **Allowed Locations**: Restricts resource deployment to specific locations.
3. **NICs without Public IPs**: Ensures network interfaces do not have public IPs.
4. **Require Tags on Resource Groups**: Enforces specific tags on resource groups.

## Required Inputs

The following variables are required for module execution:

| Name                     | Description                                    | Type              | Default | Required |
|--------------------------|------------------------------------------------|-------------------|---------|:--------:|
| `management_groups_root` | Configuration for the root management group.   | list(object)      | n/a     | yes      |
| `management_groups_level1` | Configuration for Level 1 management groups. | list(object)      | n/a     | yes      |
| `management_groups_level2` | Configuration for Level 2 management groups. | list(object)      | n/a     | yes      |
| `subscription_ids`       | List of subscription IDs for policy scope.     | list(string)      | n/a     | yes      |
| `tags`                   | Tags to enforce on resources.                 | map(string)       | n/a     | yes      |
| `locations`              | Allowed locations for resource deployments.    | list(string)      | n/a     | yes      |

## Example `.tfvars` File

```hcl
# Management Groups Configuration
management_groups_root = [
  {
    name         = "Accern-Root"
    display_name = "Accern Root"
    parent_id    = "/providers/Microsoft.Management/managementGroups/7aaf6f39-b967-4e4d-a180-8a7f346a77a4"
  }
]

management_groups_level1 = [
  {
    name         = "acn-landingzones"
    display_name = "Accern Landing Zones"
    parent_id    = "/providers/Microsoft.Management/managementGroups/Accern-Root"
  },
  {
    name         = "acn-platform"
    display_name = "Accern Platform"
    parent_id    = "/providers/Microsoft.Management/managementGroups/Accern-Root"
  }
]

management_groups_level2 = [
  {
    name         = "acn-platform-services"
    display_name = "Accern Platform Services"
    parent_id    = "/providers/Microsoft.Management/managementGroups/acn-platform"
    subscription_ids = ["570c29bd5a12468199c29547830dfabb", "56d8a3f1dd0644428a8cf4441aef7471"]
  },
  {
    name         = "acn-production"
    display_name = "Accern Landing Zones Production"
    parent_id    = "/providers/Microsoft.Management/managementGroups/acn-landingzones"
    subscription_ids = ["94194454366747cba7ce52840f429aa9"]
  }
]

# Policies Configuration
locations = ["eastus", "eastus2"]
tags = {
  Environment = "Production"
  deploymentBy = "Terraform"
}
```

## Terraform deployment 

- To initialize the backend and test the deployment, use the commands from the management folder:
  ```bash
  terraform init 
 
  terraform plan 
  ```

- To deploy, use the command:
  ```bash
  terraform apply 
  ```

## Notes

- Ensure you have the required permissions for creating management groups and assigning policies (Global Admin).
- Ensure you have permissions to Terraform Backend Storage account (minimal: Storage Blob Data Contributor)
- Update the subscription IDs and management group parent IDs as per your Azure environment.
