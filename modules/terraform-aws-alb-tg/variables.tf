variable "target_group_name" {
  type        = string
  description = "Name of the AWS target group."
}

variable "target_group_port" {
  type        = number
  description = "Port for the AWS target group."
}

variable "health_check_path" {
  type        = string
  description = "Health check path for the target group."
}

variable "routing_path" {
  type        = string
  description = "Traffic route path for the target group."
}

variable "alb_listner_priority" {
  type        = number
  description = "Listener priority for ALB HTTPS rules."
}

variable "api_domain_name" {
  type        = string
  description = "Domain name for ALB HTTPS rules."
}

variable "vpc_id" {
  type        = string
  description = "ID of the AWS VPC."
}

variable "health_check_matcher" {
  type        = number
  default     = 200
  description = "Health check matcher value for the target group."
}

variable "alb_https_listener_arn" {
  type        = string
  description = "ALB HTTPS Listner ARN"
}

variable "tags" {
  type = object({
    environment = string
  })
  validation {
    condition     = contains(["dev", "beta", "prod"], var.tags.environment)
    error_message = "Invalid environment tag value. Must be 'dev', 'beta', or 'prod'."
  }
  description = "Tag values based on the different environments (dev, beta, prod)."
}
