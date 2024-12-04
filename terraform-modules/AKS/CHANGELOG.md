## 1.0.0 (Unreleased)
Initial setup and configuration for the AKS Terraform module.
[1.0.0] - 2024-05-10

### Added
**Azure Kubernetes Service Deployment:** Configuration to deploy an AKS cluster with customizable node pools, networking settings, and identity management.

**Node Pools:** Support for both default and additional node pools, allowing for detailed specifications including VM size, count, auto-scaling, and subnet assignments.

**Networking:** Configuration options for network plugin, network policy, and load balancer SKU to customize the networking of the AKS cluster.

**Security and Identity:** Setup for role-based access control with options for Azure AD integration and system-assigned identities.

**Outputs:** Detailed outputs for cluster ID, kube config, node resource group, API server address, and identity principal ID.

**Documentation:** Basic README setup with examples for module usage and outputs described.

## Fixed
Placeholder for any bugs fixed in this release.
## Changed
Placeholder for any changes made in this release.
## Security
Configured role-based access control to enhance security within the AKS environment.
