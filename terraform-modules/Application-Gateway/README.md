# terraform-azurerm-application-gateway

This module deploys an [Azure Application Gateway](https://learn.microsoft.com/en-us/azure/application-gateway/overview) in Azure, providing a highly available and scalable web traffic load balancer.

## Features

- Deployment of an Azure Application Gateway with customizable frontend and backend configurations.
- Support for static public IP allocation.
- Configurable HTTP settings, listeners, and routing rules.
- Tags support for resource management.

Ensure your environment variables are set as shown:

```shell
export ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
export ARM_TENANT_ID="<azure_subscription_tenant_id>"
export ARM_CLIENT_ID="<service_principal_appid>"
export ARM_CLIENT_SECRET="<service_principal_password>"
```

## Requirements

| Name      | Version        |
|-----------|----------------|
| terraform | >= 1.3         |
| azurerm   | >= 3.0, < 4.0  |

## Providers

| Name    | Version        |
|---------|----------------|
| azurerm | >= 3.0, < 4.0  |

## Modules

No modules.

## Resources

| Name                                    | Type     |
|-----------------------------------------|----------|
| azurerm_public_ip.public_ip             | resource |
| azurerm_application_gateway.network     | resource |

## Inputs

| Name                          | Description                                                               | Type          | Default        | Required |
|-------------------------------|---------------------------------------------------------------------------|---------------|----------------|:--------:|
| `appgtw_name`                 | The name of the Application Gateway                                        | `string`      | n/a            | yes      |
| `resource_group_name`         | The name of the resource group                                             | `string`      | n/a            | yes      |
| `location`                    | The location/region where the Application Gateway is created               | `string`      | n/a            | yes      |
| `sku_name`                    | The SKU name for the Application Gateway                                   | `string`      | n/a            | yes      |
| `sku_tier`                    | The SKU tier for the Application Gateway                                   | `string`      | n/a            | yes      |
| `sku_capacity`                | The SKU capacity for the Application Gateway                               | `number`      | n/a            | yes      |
| `gateway_ip_config_name`      | The name of the gateway IP configuration                                   | `string`      | n/a            | yes      |
| `subnet_id`                   | The ID of the subnet                                                       | `string`      | n/a            | yes      |
| `frontend_port_name`          | The name of the frontend port                                              | `string`      | n/a            | yes      |
| `frontend_port_number`        | The port number for the frontend port                                      | `number`      | n/a            | yes      |
| `frontend_ip_configuration_name` | The name of the frontend IP configuration                              | `string`      | n/a            | yes      |
| `public_ip_address_id`        | The ID of the public IP address (if not creating a new one)                | `string`      | n/a            | yes      |
| `backend_address_pool_name`   | The name of the backend address pool                                       | `string`      | n/a            | yes      |
| `http_setting_name`           | The name of the HTTP settings                                              | `string`      | n/a            | yes      |
| `http_setting_cookie_based_affinity` | The cookie-based affinity setting                                   | `string`      | `Disabled`     | yes      |
| `http_setting_path`           | The path for the HTTP settings                                             | `string`      | n/a            | yes      |
| `http_setting_port`           | The port for the HTTP settings                                             | `number`      | n/a            | yes      |
| `http_setting_protocol`       | The protocol for the HTTP settings                                         | `string`      | n/a            | yes      |
| `http_setting_request_timeout`| The request timeout for the HTTP settings                                  | `number`      | n/a            | yes      |
| `listener_name`               | The name of the HTTP listener                                              | `string`      | n/a            | yes      |
| `listener_protocol`           | The protocol for the HTTP listener                                         | `string`      | n/a            | yes      |
| `request_routing_rule_name`   | The name of the request routing rule                                       | `string`      | n/a            | yes      |
| `request_routing_rule_priority` | The priority of the request routing rule                                | `number`      | n/a            | yes      |
| `request_routing_rule_type`   | The type of the request routing rule                                       | `string`      | n/a            | yes      |
| `create_public_ip`            | Flag to decide if a new public IP should be created                        | `bool`        | `false`        | no       |

## Outputs

| Name                         | Description                                         |
|------------------------------|-----------------------------------------------------|
| `application_gateway_id`     | The ID of the Application Gateway                   |
| `application_gateway_name`   | The name of the Application Gateway                 |
| `application_gateway_public_ip` | The public IP address ID of the Application Gateway |


## Example


```hcl


module "application_gateway" {
  source                          = "../../modules/Azure-Application_Gateway"
  appgtw_name                     = "tfpoc-appgtw"
  resource_group_name             = "appgtw-rg"
  location                        = "eastus"
  sku_name                        = "Standard_v2"
  sku_tier                        = "Standard_v2"
  sku_capacity                    = 2
  gateway_ip_config_name          = "tfpoc-gateway-ip-config"
  subnet_id                       = "/subscriptions/12345678-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/appgtw-rg/providers/Microsoft.Network/virtualNetworks/az-lb-vnet/subnets/default"
  frontend_port_name              = "tfpoc-frontend-port"
  frontend_port_number            = 80
  frontend_ip_configuration_name  = "tfpoc-frontend-ip-config"
  public_ip_address_id            = "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.Network/publicIPAddresses/<public-ip-name>"
  backend_address_pool_name       = "tfpoc-backend-pool"
  http_setting_name               = "tfpoc-http-setting"
  http_setting_cookie_based_affinity = "Disabled"
  http_setting_path               = "/path1/"
  http_setting_port               = 80
  http_setting_protocol           = "Http"
  http_setting_request_timeout    = 60
  listener_name                   = "tfpoc-listener"
  listener_protocol               = "Http"
  request_routing_rule_name       = "tfpoc-request-routing-rule"
  request_routing_rule_priority   = 1
  request_routing_rule_type       = "Basic"
  create_public_ip                = false  # Set to true if you want to create a new public IP
}

```