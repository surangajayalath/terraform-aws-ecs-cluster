variable "target_group_name" {
  type = string
}

variable "target_group_port" {
  type = number
}

variable "health_check_path" {
  type = string
}

variable "routing_path" {
  type = string
}

variable "alb_https_listener_arn" {
  type = string
}

variable "alb_listner_priority" {
  type = number
}

variable "domain_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "health_check_matcher" {
  type = number
  default = 200
}

variable "tags" {
  type = object({
    environment = string
    product = string
  })
  validation {
    condition     = contains(["dev", "beta", "prod"], var.tags.environment)
    error_message = "invalid tag values"
  }
}