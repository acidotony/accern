
# module "management_groups_root" {
#   source = "../../terraform-modules/management-group" 

#   management_groups = [
#     {
#       name           = "Accern-Root"
#       display_name   = "Accern Root"
#       parent_id      = "/providers/Microsoft.Management/managementGroups/7aaf6f39-b967-4e4d-a180-8a7f346a77a4"

#     }
#   ]
# }

# module "management_groups_level1" {
#   source = "../../management-group" 
#   depends_on = [ module.management_groups_root ]
#   management_groups = [
#     {
#       name           = "acn-landingzones"
#       display_name   = "Accern Landing Zones"
#       parent_id      = "/providers/Microsoft.Management/managementGroups/Accern-Root"
 
#     },
#     {
#       name           = "acn-platform"
#       display_name   = "Accern Platform"
#       parent_id      = "/providers/Microsoft.Management/managementGroups/Accern-Root"

#     },
#     {
#       name           = "acn-sandboxes"
#       display_name   = "Accern Sandboxes"
#       parent_id      = "/providers/Microsoft.Management/managementGroups/Accern-Root"

#     },
#     {
#       name           = "acn-decommissioned"
#       display_name   = "Accern Decommissioned"
#       parent_id      = "/providers/Microsoft.Management/managementGroups/Accern-Root"

#     }
#   ]
# }

# module "management_groups_level2" {
#   source = "../../management-group" 
#   depends_on = [ module.management_groups_level1 ]
#   management_groups = [
#     {
#       name           = "acn-platform-services"
#       display_name   = "Accern Platform Services"
#       parent_id      = "/providers/Microsoft.Management/managementGroups/acn-platform"
#       subscription_ids = ["570c29bd5a12468199c29547830dfabb", "56d8a3f1dd0644428a8cf4441aef7471"]

#     },
#     {
#       name           = "acn-production"
#       display_name   = "Accern Landing Zones Production"
#       parent_id      = "/providers/Microsoft.Management/managementGroups/acn-landingzones"
#       subscription_ids = ["94194454366747cba7ce52840f429aa9"]

#     },
#         {
#       name           = "acn-development"
#       display_name   = "Accern Landing Zones Development"
#       parent_id      = "/providers/Microsoft.Management/managementGroups/acn-landingzones"
#       subscription_ids = [" f9a902feb24f4d6cadbf93fd8ad934ac"]

#     }
#   ]
# }


# ## Default Policies

# module "mfa_for_owners" {
#   source = "../azure_policies/mfa-for-owners"

#   management_group_ids = ["/providers/Microsoft.Management/managementGroups/Accern-Root"]
#   subscription_ids     = ["2489b659-81f7-4abe-9eb4-e4cca732d892"]
# }

# module "allowed_locations" {
#   source = "../../terraform-modules/azure-policies/allowed-locations"

#   subscription_ids     = ["e12ce4d3-a17b-4aa7-8b8a-10abb4546edf"]
#   management_group_id = "/providers/Microsoft.Management/managementGroups/Accern-Root"
#   locations            = ["eastus", "eastus2"]
# }

# module "allowed_skus" {
#   source = "../../terraform-modules/azure-policies/allowed-skus"

#   subscription_ids     = ["e12ce4d3-a17b-4aa7-8b8a-10abb4546edf"]
#   management_group_id = "/providers/Microsoft.Management/managementGroups/acn-landingzones"
#   skus                 = ["Standard_B2s", "Standard_D2s_v3"]
# }


# module "nics_no_pip" {
#   source = "../../terraform-modules/azure-policies/nics-no-pip"

#   management_group_id = ["/providers/Microsoft.Management/managementGroups/acn-landingzones"]
#   subscription_ids     = ["2489b659-81f7-4abe-9eb4-e4cca732d892"]
# }

# module "require_tag_on_rg" {
#   source = "../../terraform-modules/azure-policies/require-tag-on-rg"
#   subscription_ids     = ["2489b659-81f7-4abe-9eb4-e4cca732d892"]
#   management_group_ids = ["/providers/Microsoft.Management/managementGroups/Accern-Root"]
#   tag_name                  = ["Environment", "deploymentBy"]
# }