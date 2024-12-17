
# Terraform Key Vault Module

This Terraform module deploys an Azure Key Vault and configures access policies for secure storage and management of sensitive information such as secrets, keys, and certificates.

## Features

- **Key Vault Deployment**: Creates a Key Vault with specified location, resource group, and tenant ID.
- **Access Policy Configuration**: Configures access policies with secret permissions for a specific object ID.
- **Soft Delete Retention**: Enables soft delete with a retention period of 7 days for recovery.
- **Outputs**: Provides the Key Vault ID and name.

## Usage Example

To use this module in your Terraform configuration, use the following syntax:

```hcl
module "key_vault" {
  source               = "../modules/key_vault"  // Adjust the source location based on your directory structure
  name                 = "my-key-vault"
  location             = "East US"
  resource_group_name  = "my-resource-group"
  tenant_id            = "tenant-id"
  object_id            = "object-id"
}
```

## Required Inputs

The following input variables are required:

| Name                  | Description                                           | Type           | Default | Required |
|-----------------------|-------------------------------------------------------|----------------|---------|:--------:|
| `name`               | The name of the Key Vault.                            | string         | n/a     | yes      |
| `location`           | The location/region for the Key Vault.                | string         | n/a     | yes      |
| `resource_group_name` | The name of the resource group for the Key Vault.     | string         | n/a     | yes      |
| `tenant_id`          | The tenant ID associated with the Key Vault.          | string         | n/a     | yes      |
| `object_id`          | The object ID for which the access policy will be configured. | string | n/a     | yes      |

## Outputs

| Name             | Description                              |
|------------------|------------------------------------------|
| `key_vault_id`   | The resource ID of the Key Vault.        |
| `key_vault_name` | The name of the Key Vault.               |

## Providers

| Name     | Version  |
|----------|----------|
| azurerm  | >= 4.11.0 |

## Features

- **Access Policy Control**: Assign specific secret permissions to an object ID for secure operations.
- **Soft Delete Protection**: Includes a retention period for deleted Key Vaults to enable recovery.
- **Customizable Deployment**: Supports flexible configuration for location, resource group, and tenant.
