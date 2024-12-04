variable "appgtw_name" {
  description = "The name of the Application Gateway"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location/region where the Application Gateway is created"
  type        = string
}

variable "sku_name" {
  description = "The SKU name for the Application Gateway"
  type        = string
}

variable "sku_tier" {
  description = "The SKU tier for the Application Gateway"
  type        = string
}

variable "sku_capacity" {
  description = "The SKU capacity for the Application Gateway"
  type        = number
}

variable "gateway_ip_config_name" {
  description = "The name of the gateway IP configuration"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

variable "frontend_port_name" {
  description = "The name of the frontend port"
  type        = string
}

variable "frontend_port_number" {
  description = "The port number for the frontend port"
  type        = number
}

variable "frontend_ip_configuration_name" {
  description = "The name of the frontend IP configuration"
  type        = string
}

variable "public_ip_address_id" {
  description = "The ID of the public IP address (if not creating a new one)"
  type        = string
}

variable "backend_address_pool_name" {
  description = "The name of the backend address pool"
  type        = string
}

variable "http_setting_name" {
  description = "The name of the HTTP settings"
  type        = string
}

variable "http_setting_cookie_based_affinity" {
  description = "The cookie-based affinity setting"
  type        = string
  default = "Disabled"
}

variable "http_setting_path" {
  description = "The path for the HTTP settings"
  type        = string
}

variable "http_setting_port" {
  description = "The port for the HTTP settings"
  type        = number
}

variable "http_setting_protocol" {
  description = "The protocol for the HTTP settings"
  type        = string
}

variable "http_setting_request_timeout" {
  description = "The request timeout for the HTTP settings"
  type        = number
}

variable "listener_name" {
  description = "The name of the HTTP listener"
  type        = string
}

variable "listener_protocol" {
  description = "The protocol for the HTTP listener"
  type        = string
}

variable "request_routing_rule_name" {
  description = "The name of the request routing rule"
  type        = string
}

variable "request_routing_rule_priority" {
  description = "The priority of the request routing rule"
  type        = number
}

variable "request_routing_rule_type" {
  description = "The type of the request routing rule"
  type        = string
}

variable "create_public_ip" {
  description = "Flag to decide if a new public IP should be created"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to assign to the resources"
  type        = map(string)
}
