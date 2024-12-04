resource "azurerm_storage_account" "sa" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind = var.account_kind

  tags = var.tags

  dynamic "access_tier" {
    for_each = var.access_tier != null ? [var.access_tier] : []
    content {
      access_tier = access_tier.value
    }
  }

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
