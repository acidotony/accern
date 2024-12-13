
# Terraform Root Module for Landing Zone Connectivity Azure Infrastructure


This Terraform root module orchestrates the deployment of the Azure Landing Zone, including all resources related to connectivity in a hub-and-spoke network topology. Key components include Virtual Networks, Subnets, Application Gateways, and Network Security Groups.

## Features

- **Resource Group Deployment**: Creates the resource group for all dependent resources.
- **Virtual Network and Subnets**: Deploys a hub VNet with configurable subnets and address spaces.
- **Application Gateway with NSG**: Configures an Application Gateway and secures it with a Network Security Group (NSG).
- **Flexible Configuration**: Offers dynamic configurations via `.tfvars` file.
- **Remote State Management**: Configures Terraform Backend state storage using Azure Blob Storage.


## Components Deployed

### Resource Group
The resource group acts as the container for all other Azure resources in the deployment.

### Virtual Network
A hub VNet is created with the specified address space and tags.

### Subnets
Subnets within the hub VNet are deployed with flexible configuration for delegation, service endpoints, and address prefixes.

### Application Gateway
An Application Gateway is deployed with optional WAF policies and integration with a dedicated subnet and NSG.


## Required Inputs

The following input variables are required:

| Name                                   | Description                                                                                  | Type           | Default | Required |
|----------------------------------------|----------------------------------------------------------------------------------------------|----------------|---------|:--------:|
| `resourceGroupName`                    | The name of the resource group.                                                             | string         | n/a     | yes      |
| `location`                             | The location of the resources.                                                              | string         | n/a     | yes      |
| `tags`                                 | Tags to assign to the resources.                                                            | map(string)    | n/a     | yes      |
| `address_space_hub`                    | Address space for the hub virtual network.                                                  | list(string)   | n/a     | yes      |
| `subnets_hub`                          | Subnets for the hub virtual network.                                                        | map(object)    | n/a     | yes      |
| `vnet_hub_name`                        | The name of the hub virtual network.                                                        | string         | n/a     | yes      |
| `applicationGatewayNsgName`            | The name of the Network Security Group for the Application Gateway subnet.                  | string         | n/a     | yes      |
| `applicationGatewayNsgRules`           | Security rules for the Application Gateway subnet NSG.                                      | list(object)   | n/a     | yes      |
| `firewallPolicyName`                   | The name of the Firewall Policy.                                                            | string         | n/a     | yes      |
| `firewallPolicyTags`                   | Tags to assign to the firewall policy.                                                      | map(string)    | n/a     | yes      |
| `applicationGatewayCreatePublicIp`     | Determines whether to create a new public IP for the Application Gateway.                   | bool           | true    | yes      |
| `applicationGatewayPublicIpAddressId`  | ID of an existing public IP to use if `applicationGatewayCreatePublicIp` is set to false.   | string         | null    | yes      |
| `applicationGatewayResourceGroupName`  | The name of the resource group for the Application Gateway.                                 | string         | n/a     | yes      |
| `applicationGatewayLocation`           | The location of the Application Gateway resources.                                          | string         | n/a     | yes      |
| `applicationGatewayName`               | The name of the Application Gateway.                                                        | string         | n/a     | yes      |
| `applicationGatewaySkuName`            | The SKU name of the Application Gateway.                                                    | string         | n/a     | yes      |
| `applicationGatewaySkuTier`            | The SKU tier of the Application Gateway.                                                    | string         | n/a     | yes      |
| `applicationGatewaySkuCapacity`        | The capacity of the Application Gateway SKU.                                                | number         | n/a     | yes      |
| `applicationGatewayGatewayIpConfigName`| The name of the gateway IP configuration.                                                   | string         | n/a     | yes      |
| `applicationGatewayFrontendPortName`   | The name of the frontend port.                                                              | string         | n/a     | yes      |
| `applicationGatewayFrontendPortNumber` | The port number of the frontend port.                                                       | number         | n/a     | yes      |
| `applicationGatewayFrontendIpConfigurationName` | The name of the frontend IP configuration.                                             | string         | n/a     | yes      |
| `applicationGatewayBackendAddressPoolName` | The name of the backend address pool.                                                  | string         | n/a     | yes      |
| `applicationGatewayHttpSettingName`    | The name of the backend HTTP settings.                                                     | string         | n/a     | yes      |
| `applicationGatewayHttpSettingCookieBasedAffinity` | Whether cookie-based affinity is enabled for the backend HTTP settings.              | string         | n/a     | yes      |
| `applicationGatewayHttpSettingPath`    | The path to be used by the backend HTTP settings.                                          | string         | n/a     | yes      |
| `applicationGatewayHttpSettingPort`    | The port used by the backend HTTP settings.                                                | number         | n/a     | yes      |
| `applicationGatewayHttpSettingProtocol`| The protocol used by the backend HTTP settings.                                            | string         | n/a     | yes      |
| `applicationGatewayHttpSettingRequestTimeout` | The request timeout for the backend HTTP settings.                                    | number         | n/a     | yes      |
| `applicationGatewayListenerName`       | The name of the HTTP listener.                                                             | string         | n/a     | yes      |
| `applicationGatewayListenerProtocol`   | The protocol used by the HTTP listener.                                                   | string         | n/a     | yes      |
| `applicationGatewayRequestRoutingRuleName` | The name of the request routing rule.                                                 | string         | n/a     | yes      |
| `applicationGatewayRequestRoutingRulePriority` | The priority of the request routing rule.                                             | number         | n/a     | yes      |
| `applicationGatewayRequestRoutingRuleType` | The type of the request routing rule.                                                | string         | n/a     | yes      |
| `applicationGatewayTags`               | Tags to associate with the Application Gateway resources.                                 | map(string)    | {}      | yes      |
| `applicationGatewaySubnetName`         | The Application Gateway Subnet Name.                                                     | string         | n/a     | yes      |
| `deploy_app_gateway`                   | Flag to determine whether to deploy the Application Gateway.                              | bool           | false   | yes      |

## Example `.tfvars` File

```hcl
#### Deployment Flags ####
deploy_app_gateway = true

#### Global ####
resourceGroupName = "acn-net-prd-use2-rg-01"
location          = "eastus2"
tags = {
  environment = "Management"
  project     = "Accern"
  deploymentBy = "Terraform"
}

address_space_hub = ["10.0.0.0/21"]

subnets_hub = {
  "acn-hub-prd-use2-appgw-snet" = {
    address_prefixes        = ["10.0.5.0/24"]
    service_endpoints       = []
    delegation              = false
    delegation_name         = ""
    service_delegation_name = ""
    actions                 = []
  }
  "acn-hub-prd-use2-web-snet" = {
    address_prefixes        = ["10.0.4.0/24"]
    service_endpoints       = []
    delegation              = false
    delegation_name         = ""
    service_delegation_name = ""
    actions                 = []
  }
}

applicationGatewayNsgRules = [
  {
    name                       = "Allow-HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "Allow-HTTPS"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]
```

## Outputs

| Name                 | Description                                      |
|----------------------|--------------------------------------------------|
| `resource_group_name` | Resource Group Name of the hub virtual network. |
| `vnet_hub_id`        | ID of the hub virtual network.                   |
| `vnet_hub_name`      | Name of the hub virtual network.                 |
| `address_space`      | Address space for the virtual networks.          |
| `address_prefixes`   | Address prefixes for the virtual network subnets.|
| `appgtw_subnet_id`   | ID of the Application Gateway subnet.            |

## Remote State Configuration

he Terraform state is stored in an Azure Storage Account. This setup ensures that the Terraform state file is securely stored and accessible by multiple team members for consistent deployments. The Storage Account must already be deployed in a different resource group, and the Terraform deployment process must have the necessary permissions to access this Storage Account.

### Backend Configuration

The backend is configured to use Azure Storage as follows:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "<resource group name>"  # The resource group containing the storage account
    storage_account_name = "<GLobal unique storage account name>"  # The name of the storage account for state management
    container_name       = "accern-<environment>"  # The container in the storage account for the state file
    key                  = "connectivity.terraform.tfstate"  # The key (path) for the state file
  }
}
```

## Features

- **Infrastructure as Code**: Modular and reusable Terraform configurations.
- **Flexible Deployment**: Supports customization through `.tfvars` files.
- **Secure State Management**: Uses Azure Blob Storage for remote state.
