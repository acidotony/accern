module "management_groups_root" {
  source = "../../terraform-modules/management-group" 

  management_groups = [
    {
      name           = "Accern-Root"
      display_name   = "Accern Root"
      parent_id      = "/providers/Microsoft.Management/managementGroups/ba25e9e3-d4c7-404f-9b1b-fabe3a40f2d3"

    }
  ]
}

module "management_groups_level1" {
  source = "../../terraform-modules/management-group" 
  depends_on = [ module.management_groups_root ]
  management_groups = [
    {
      name           = "acn-landingzones"
      display_name   = "Accern Landing Zones"
      parent_id      = "/providers/Microsoft.Management/managementGroups/Accern-Root"
 
    },
    {
      name           = "acn-platform"
      display_name   = "Accern Platform"
      parent_id      = "/providers/Microsoft.Management/managementGroups/Accern-Root"

    },
    {
      name           = "acn-sandboxes"
      display_name   = "Accern Sandboxes"
      parent_id      = "/providers/Microsoft.Management/managementGroups/Accern-Root"

    },
    {
      name           = "acn-decommissioned"
      display_name   = "Accern Decommissioned"
      parent_id      = "/providers/Microsoft.Management/managementGroups/Accern-Root"

    }
  ]
}

module "management_groups_level2" {
  source = "../../terraform-modules/management-group" 
  depends_on = [ module.management_groups_level1 ]
  management_groups = [
    {
      name           = "acn-platform-services"
      display_name   = "Accern Platform Services"
      parent_id      = "/providers/Microsoft.Management/managementGroups/acn-platform"
      subscription_ids = ["/subscriptions/e12ce4d3-a17b-4aa7-8b8a-10abb4546edf"]

    },
    {
      name           = "acn-production"
      display_name   = "Accern Landing Zones Production"
      parent_id      = "/providers/Microsoft.Management/managementGroups/acn-landingzones"
      subscription_ids = ["/subscriptions/2489b659-81f7-4abe-9eb4-e4cca732d892"]

    },
        {
      name           = "acn-development"
      display_name   = "Accern Landing Zones Development"
      parent_id      = "/providers/Microsoft.Management/managementGroups/acn-landingzones"
      #subscription_ids = ["f9a902feb24f4d6cadbf93fd8ad934ac"]

    }
  ]
}


## Default Policies

module "mfa_for_owners" {
  source = "../../terraform-modules/azure-policies/mfa-for-owners"

  management_group_ids = ["/providers/Microsoft.Management/managementGroups/Accern-Root"]
  subscription_ids     = ["e12ce4d3-a17b-4aa7-8b8a-10abb4546edf"]
  depends_on = [ module.management_groups_level2 ]
}

module "allowed_locations" {
  source = "../../terraform-modules/azure-policies/allowed-locations"
  depends_on = [ module.management_groups_level2 ]
  subscription_ids     = [
    "e12ce4d3-a17b-4aa7-8b8a-10abb4546edf"
  ]
  management_group_id  = "/providers/Microsoft.Management/managementGroups/Accern-Root"
  locations            = ["eastus2", "westus2"]
}


module "allowed_skus" {
  source = "../../terraform-modules/azure-policies/allowed-skus"
  depends_on = [ module.management_groups_level2 ]
  subscription_ids     = ["e12ce4d3-a17b-4aa7-8b8a-10abb4546edf"]
  management_group_id = "/providers/Microsoft.Management/managementGroups/acn-landingzones"
  skus                 = ["Standard_B2s", "Standard_D2s_v3"]
}


module "nics_no_pip" {
  source = "../../terraform-modules/azure-policies/nics-no-pip"
  depends_on = [ module.management_groups_level2 ]
  management_group_id = "/providers/Microsoft.Management/managementGroups/acn-landingzones"
  subscription_ids     = ["e12ce4d3-a17b-4aa7-8b8a-10abb4546edf"]
}

module "require_tag_on_rg" {
  source = "../../terraform-modules/azure-policies/require-tag-on-rg"
  depends_on = [ module.management_groups_level2 ]
  subscription_ids     = []
  management_group_ids = ["/providers/Microsoft.Management/managementGroups/Accern-Root"]
  tags                  = ["Environment", "deploymentBy"]
}
