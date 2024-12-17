// Terraform Providers version tested 4.11.0 and 4.12.0

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

