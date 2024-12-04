
module "management_groups_root" {
  source = "../../management-group" 

  management_groups = [
    {
      name           = "Accern-Root"
      display_name   = "Accern Root"
      parent_id      = "/providers/Microsoft.Management/managementGroups/ba25e9e3-d4c7-404f-9b1b-fabe3a40f2d3"

    }
  ]
}

module "management_groups_level1" {
  source = "../../management-group" 
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
  source = "../../management-group" 
  depends_on = [ module.management_groups_level1 ]
  management_groups = [
    {
      name           = "acn-platform-services"
      display_name   = "Accern Platform Services"
      parent_id      = "/providers/Microsoft.Management/managementGroups/acn-platform"
      subscription_ids = ["acc-platform-managment id", "cc-platform-connectivity id"]

    },
    {
      name           = "acn-production"
      display_name   = "Accern Landing Zones Production"
      parent_id      = "/providers/Microsoft.Management/managementGroups/acn-landingzones"
      subscription_ids = ["acn-production id"]

    },
        {
      name           = "acn-development"
      display_name   = "Accern Landing Zones Development"
      parent_id      = "/providers/Microsoft.Management/managementGroups/acn-landingzones"
      subscription_ids = ["acn-development id"]

    }
  ]
}


## Default Policies

module "mfa_for_owners" {
  source = "../azure_policies/mfa-for-owners"

  management_group_ids = ["/providers/Microsoft.Management/managementGroups/Accern-Root"]
  subscription_ids     = ["2489b659-81f7-4abe-9eb4-e4cca732d892"]
}

module "allowed_locations" {
  source = "../azure_policies/allowed-locations"

  subscription_ids     = ["e12ce4d3-a17b-4aa7-8b8a-10abb4546edf"]
  management_group_ids = ["/providers/Microsoft.Management/managementGroups/Accern-Root"]
  locations            = ["eastus", "eastus2"]
}

module "allowed_skus" {
  source = "../azure_policies/allowed-skus"

  subscription_ids     = ["e12ce4d3-a17b-4aa7-8b8a-10abb4546edf"]
  management_group_ids = ["/providers/Microsoft.Management/managementGroups/acn-landingzones"]
  skus                 = ["Standard_B2s", "Standard_D2s_v3"]
}


module "nics_no_pip" {
  source = "../azure_policies/nics-no-pip"

  management_group_ids = ["/providers/Microsoft.Management/managementGroups/acn-landingzones"]
  subscription_ids     = ["2489b659-81f7-4abe-9eb4-e4cca732d892"]
}

module "require_tag_on_rg" {
  source = "../azure_policies/require-tag-on-rg"

  subscription_ids     = ["2489b659-81f7-4abe-9eb4-e4cca732d892"]
  management_group_ids = ["/providers/Microsoft.Management/managementGroups/Accern-Root"]
  tags                 = ["Environment", "deploymentBy"]
}