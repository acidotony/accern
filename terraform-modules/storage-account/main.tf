terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.12.0"
    }
  }
} 

resource "azurerm_storage_account" "sa" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind = var.account_kind

  tags = var.tags

  access_tier = var.access_tier != null ? var.access_tier : null

  blob_properties {
    change_feed_enabled = var.blob_change_feed_enabled
    versioning_enabled  = var.blob_versioning_enabled
    container_delete_retention_policy {
      days = var.container_delete_retention_days
    }
    delete_retention_policy {
      days = var.blob_delete_retention_days
    }
    restore_policy {
      days = var.blob_restore_policy_days
    }
  }

}
