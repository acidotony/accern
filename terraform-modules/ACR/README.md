
# Terraform Azure Container Registry Module

This Terraform module deploys an Azure Container Registry (ACR), which provides a managed Docker registry service based on the Docker Registry 2.0 specification. This service allows you to store and manage container images across all types of Azure deployments.

## Features

- **Registry Creation**: Deploy an ACR with customizable SKUs including Basic, Standard, and Premium.
- **Admin Access**: Optionally enable admin access to the registry.
- **Public Access**: Control whether the registry is accessible over the internet.
- **Tags**: Apply tags to resources for cost tracking and management.
- **Georeplication**: Support for georeplicating the registry to multiple Azure regions.

## Usage Example

To use this module in your Terraform configuration, use the following syntax:

```hcl
module "azure_container_registry" {
  source                  = "../modules/acr"  // Adjust the source location based on your directory structure
  acr_name                = "newacr"
  resource_group_name     = "acrRG"
  location                = "East US"
  acr_sku                 = "Premium" // expected sku to be one of ["Basic" "Standard" "Premium"]
  admin_enabled           = false
  public_network_access_enabled = false
  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
```

## Required Inputs

The following input variables are required:

| Name                  | Description                           | Type   | Default | Required |
|-----------------------|---------------------------------------|--------|---------|:--------:|
| `acr_name`            | The name of the container registry.   | string | n/a     | yes      |
| `resource_group_name` | The name of the resource group.       | string | n/a     | yes      |
| `location`            | The location for the ACR deployment.  | string | n/a     | yes      |
| `acr_sku`             | The SKU of the ACR.                   | string | n/a     | yes      |

## Optional Inputs

| Name                          | Description                                               | Type    | Default |
|-------------------------------|-----------------------------------------------------------|---------|---------|
| `admin_enabled`               | Enable admin user for the registry.                       | bool    | `false` |
| `public_network_access_enabled` | Allow public access to the registry.                     | bool    | `true`  |
| `tags`                        | A map of tags to assign to the resource.                  | map     | `{}`    |

## Outputs

| Name                    | Description                                        |
|-------------------------|----------------------------------------------------|
| `acr_id`                | The resource ID of the ACR.                        |
| `acr_login_server`      | The login server URL of the ACR.                   |
| `acr_admin_username`    | The admin username, if admin access is enabled.    |
| `acr_admin_password`    | The admin password, if admin access is enabled.    |

## Providers

| Name     | Version |
|----------|---------|
| azurerm  | >= 4.0  |


