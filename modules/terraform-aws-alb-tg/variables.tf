variable "target_group_name" {
  type        = string
  description = "AWS Target Group Name"
}

variable "target_group_port" {
  type        = number
  description = "AWS Target Group Port"
}

variable "health_check_path" {
  type        = string
  description = "Health Check path for Target Group"
}

variable "routing_path" {
  type        = string
  description = "Traffic Route path for Target Group"
}

variable "alb_https_listener_arn" {
  type        = string
  description = "AWS ALB HTTPS Listener ARN"
}

variable "alb_listner_priority" {
  type        = number
  description = "Listener Priority for ALB HTTPS Rules"
}

variable "domain_name" {
  type        = string
  description = "Domain name to ALB HTTPS Rules"
}

variable "vpc_id" {
  type        = string
  description = "AWS VPC ID"
}

variable "health_check_matcher" {
  type        = number
  default     = 200
  description = "Health Check Matcher Value for Target Group"
}

variable "tags" {
  type = object({
    environment = string
  })

  validation {
    condition     = contains(["dev", "beta", "prod"], var.tags.environment)
    error_message = "Invalid Env Tag Value..."
  }
  description = "Tag Values based on the Different Environmets"
}