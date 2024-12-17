
# Terraform Storage Account Module

This Terraform module creates an Azure Storage Account with advanced configuration options such as blob versioning, change feed, and retention policies.

## Features

- **Storage Account Deployment**: Creates a storage account in the specified location and resource group.
- **Flexible Configuration**: Supports configuration for account kind, replication type, access tier, and more.
- **Blob Properties**: Includes advanced settings for blob change feed, versioning, and retention policies.
- **Outputs**: Provides the storage account name and ID.

## Usage Example

To use this module in your Terraform configuration, use the following syntax:

```hcl
module "storage_account" {
  source               = "../modules/storage_account"  // Adjust the source location based on your directory structure
  name                 = "mystorageaccount"
  resource_group_name  = "my-resource-group"
  location             = "East US"
  account_tier         = "Standard"
  account_replication_type = "LRS"
  account_kind         = "StorageV2"
  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
  access_tier                = "Hot"
  blob_change_feed_enabled   = true
  blob_versioning_enabled    = true
  container_delete_retention_days = 14
  blob_delete_retention_days = 14
  blob_restore_policy_days   = 7
}
```

## Required Inputs

The following input variables are required:

| Name                  | Description                                           | Type           | Default | Required |
|-----------------------|-------------------------------------------------------|----------------|---------|:--------:|
| `name`               | The name of the Storage Account.                      | string         | n/a     | yes      |
| `resource_group_name` | The name of the resource group for the Storage Account.| string        | n/a     | yes      |
| `location`           | The location/region for the Storage Account.          | string         | n/a     | yes      |
| `account_replication_type` | The replication type for the Storage Account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS. | string | `"LRS"` | no |
| `tags`               | A map of tags to apply to the Storage Account.        | map(any)       | `{}`    | no       |

## Optional Inputs

| Name                  | Description                                           | Type           | Default |
|-----------------------|-------------------------------------------------------|----------------|---------|
| `account_tier`        | The performance tier of the Storage Account. Valid options are Standard or Premium. | string | `"Standard"` |
| `account_kind`        | The kind of the Storage Account. Valid options are Storage, StorageV2, BlobStorage, etc. | string | `"StorageV2"` |
| `access_tier`         | The access tier of the Storage Account. Valid options are Hot or Cool. | string | `null` |
| `blob_change_feed_enabled` | Enable change feed events for blobs. | bool | `true` |
| `blob_versioning_enabled` | Enable versioning for blobs. | bool | `true` |
| `container_delete_retention_days` | Number of days to retain deleted containers. | number | `14` |
| `blob_delete_retention_days` | Number of days to retain deleted blobs. | number | `14` |
| `blob_restore_policy_days` | Number of days for which blobs can be restored. | number | `7` |

## Outputs

| Name                    | Description                              |
|-------------------------|------------------------------------------|
| `storage_account_name`  | The name of the Storage Account.         |
| `storage_account_id`    | The resource ID of the Storage Account.  |

## Providers

| Name     | Version  |
|----------|----------|
| azurerm  | >= 4.11.0 |

## Features

- **Advanced Blob Configuration**: Supports enabling versioning, change feed, and retention policies for containers and blobs.
- **Flexible Storage Options**: Configure tier, replication, and access settings as per requirements.
- **Comprehensive Outputs**: Provides storage account details for integration with other modules.
