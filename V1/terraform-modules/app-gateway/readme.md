
# Terraform Azure Application Gateway Module

This Terraform module deploys an Azure Application Gateway (App Gateway), which is a web traffic load balancer that enables you to manage traffic to your web applications. It provides Layer 7 routing, SSL termination, and a web application firewall (WAF).

## Features

- **Application Gateway Deployment**: Deploys an App Gateway with customizable configurations, including SKU, capacity, and IP configurations.
- **Firewall Policy**: Optionally attach a Web Application Firewall (WAF) policy for enhanced security.
- **Public or Private Frontend**: Supports both public and private IP configurations.
- **Backend Pools**: Define backend address pools to route traffic to your application servers.
- **Routing Rules**: Configure routing rules to direct incoming traffic based on listener settings.
- **Tags**: Apply tags to resources for cost tracking and management.

## Usage Example

To use this module in your Terraform configuration, use the following syntax:

```hcl
module "azure_application_gateway" {
  source                  = "../modules/application_gateway"  // Adjust the source location based on your directory structure
  appgtw_name             = "myAppGateway"
  resource_group_name     = "myResourceGroup"
  location                = "East US"
  sku_name                = "Standard_v2"
  sku_tier                = "Standard"
  sku_capacity            = 2
  gateway_ip_config_name  = "myGatewayIPConfig"
  subnet_id               = "subnet-resource-id"
  frontend_port_name      = "myFrontendPort"
  frontend_port_number    = 80
  frontend_ip_configuration_name = "myFrontendIPConfig"
  backend_address_pool_name      = "myBackendPool"
  http_setting_name             = "myHTTPSetting"
  http_setting_port             = 80
  http_setting_protocol         = "Http"
  listener_name                 = "myListener"
  listener_protocol             = "Http"
  request_routing_rule_name     = "myRoutingRule"
  request_routing_rule_type     = "Basic"
  request_routing_rule_priority = 1
  firewall_policy_name          = "myFirewallPolicy"
  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
```

## Required Inputs

The following input variables are required:

| Name                  | Description                                               | Type   | Default | Required |
|-----------------------|-----------------------------------------------------------|--------|---------|:--------:|
| `appgtw_name`         | The name of the Application Gateway.                      | string | n/a     | yes      |
| `resource_group_name` | The name of the resource group.                           | string | n/a     | yes      |
| `location`            | The location/region where the Application Gateway is created. | string | n/a     | yes      |
| `sku_name`            | The SKU name for the Application Gateway.                | string | n/a     | yes      |
| `sku_tier`            | The SKU tier for the Application Gateway.                | string | n/a     | yes      |
| `sku_capacity`        | The SKU capacity for the Application Gateway.            | number | n/a     | yes      |
| `subnet_id`           | The ID of the subnet for the Application Gateway.         | string | n/a     | yes      |
| `firewall_policy_name`| The name of the Firewall Policy.                         | string | n/a     | yes      |

## Optional Inputs

| Name                              | Description                                           | Type   | Default      | Required |
|-----------------------------------|-------------------------------------------------------|--------|--------------|:--------:|
| `gateway_ip_config_name`          | The name of the gateway IP configuration.            | string | n/a          | no       |
| `frontend_port_name`              | The name of the frontend port.                       | string | n/a          | no       |
| `frontend_port_number`            | The port number for the frontend port.               | number | n/a          | no       |
| `frontend_ip_configuration_name`  | The name of the frontend IP configuration.           | string | n/a          | no       |
| `public_ip_address_id`            | The ID of the public IP address (if not creating a new one). | string | n/a    | no       |
| `backend_address_pool_name`       | The name of the backend address pool.                | string | n/a          | no       |
| `http_setting_name`               | The name of the HTTP settings.                       | string | n/a          | no       |
| `http_setting_cookie_based_affinity` | The cookie-based affinity setting.                | string | `"Disabled"` | no       |
| `http_setting_path`               | The path for the HTTP settings.                      | string | n/a          | no       |
| `http_setting_port`               | The port for the HTTP settings.                      | number | n/a          | no       |
| `http_setting_protocol`           | The protocol for the HTTP settings.                  | string | n/a          | no       |
| `http_setting_request_timeout`    | The request timeout for the HTTP settings.           | number | 30           | no       |
| `listener_name`                   | The name of the HTTP listener.                       | string | n/a          | no       |
| `listener_protocol`               | The protocol for the HTTP listener.                  | string | n/a          | no       |
| `request_routing_rule_name`       | The name of the request routing rule.                | string | n/a          | no       |
| `request_routing_rule_priority`   | The priority of the request routing rule.            | number | n/a          | no       |
| `request_routing_rule_type`       | The type of the request routing rule.                | string | n/a          | no       |
| `create_public_ip`                | Flag to decide if a new public IP should be created. | bool   | `false`      | no       |
| `app_gateway_public_ip_allocation_method` | Application Gateway Public IP Allocation Method. | string | `"Static"`   | no       |
| `app_gateway_public_ip_sku`       | Application Gateway Public IP SKU.                   | string | `"Standard"` | no       |
| `tags`                            | Tags to assign to the resources.                     | map    | `{}`         | no       |


## Outputs

| Name                            | Description                                      |
|---------------------------------|--------------------------------------------------|
| `application_gateway_id`        | The resource ID of the Application Gateway.      |
| `application_gateway_name`      | The name of the Application Gateway.            |
| `application_gateway_public_ip` | The public IP of the Application Gateway.        |

## Providers

| Name     | Version |
|----------|---------|
| azurerm  | >= 4.0  |
