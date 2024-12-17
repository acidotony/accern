#!/bin/bash

# === Variables ===
SUBSCRIPTION_ID="12302488-c84e-40e3-b782-3f748417b5fb"
RESOURCE_GROUP="acn-tf-prd-use2-rg-01"
STORAGE_ACCOUNT_NAME="acntfstateprdst01"
LOCATION="eastus2"
STORAGE_SKU="Standard_LRS"
MIN_TLS_VERSION="TLS1_2"
SOFT_DELETE_RETENTION_DAYS=30

# === Login to Azure ===
az login

# Set Subscription
az account set --subscription "$SUBSCRIPTION_ID"

# === Create Resource Group (if it doesn't exist) ===
az group create \
  --name "$RESOURCE_GROUP" \
  --location "$LOCATION"

# === Create Storage Account ===
az storage account create \
  --name "$STORAGE_ACCOUNT_NAME" \
  --resource-group "$RESOURCE_GROUP" \
  --location "$LOCATION" \
  --sku "$STORAGE_SKU" \
  --kind StorageV2 \
  --public-network-access Enabled \
  --allow-blob-public-access true \
  --min-tls-version "$MIN_TLS_VERSION"

# === Retrieve Storage Account Key ===
STORAGE_KEY=$(az storage account keys list \
  --account-name "$STORAGE_ACCOUNT_NAME" \
  --query '[0].value' \
  --output tsv)

# === Enable Soft Delete for Blobs ===
az storage blob service-properties delete-policy update \
  --account-name "$STORAGE_ACCOUNT_NAME" \
  --account-key "$STORAGE_KEY" \
  --enable true \
  --days-retained "$SOFT_DELETE_RETENTION_DAYS"

# === Output ===
echo "Storage account '$STORAGE_ACCOUNT_NAME' created in resource group '$RESOURCE_GROUP'."
echo "Soft delete enabled with a retention period of $SOFT_DELETE_RETENTION_DAYS days."
echo "To enable blob versioning, use PowerShell or the Azure Portal."
