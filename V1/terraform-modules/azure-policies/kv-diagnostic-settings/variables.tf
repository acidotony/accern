variable "subscription_id" {
  type        = string
  description = "Subscription Id"
  default     = null  
}

variable "location" {
  type        = string
  description = "Location"
  default     = null  
}

variable "log_analytics" {
  type        = string
  description = "Log Analytics workspace"
  default     = null  
}

variable "effect" {
  type        = string
  description = "Effect"
  default     = "DeployIfNotExists"
}

variable "profile_name" {
  type        = string
  description = "Profile name"
  default     = "setbypolicy_logAnalytics"
}

variable "metrics_enabled" {
  type        = string
  description = "Enable metrics"
  default     = "False"
}

variable "logs_enabled" {
  type        = string
  description = "Enable logs"
  default     = "True"
}
