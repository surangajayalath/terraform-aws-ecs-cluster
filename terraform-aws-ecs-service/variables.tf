variable "service_name" {
  type = string
}

variable "cluster_id" {
  type = string
}

variable "ecs_cluster_launch_type" {
  type = string
  default = "FARGATE"
}

variable "assign_public_ip" {
  type = bool
  default = false
}

variable "enable_execute_command" {
  type = bool
  default = true
}

variable "task_definition_arn" {
  type = string
}

variable "desired_count" {
  type = number
}

variable "minimum_healthy_percent" {
  type = string
}

variable "maximum_percent" {
  type = string
}

variable "container_security_group" {

}
variable "private_subnet_ids" {
  type = list(string)
}

variable "target_group_arn" {
  type = string
}

variable "container_name" {
  type = string
}

variable "container_port" {
  type = string
}

variable "service_discovery_arn" {
  type = string
}

variable "enable_load_balancer" {
  description = "Boolean flag to enable/disable load balancer attachment"
  type        = bool
  default     = false
}

variable "enable_volume_mount" {
  description = "Boolean flag to enable/disable volume mount"
  type        = bool
  default     = false
}

# variable "volume_name" {
#   type    = string
#   default = ""
# }

# variable "ebs_role_arn" {
#   type    = string
#   default = ""
# }

# variable "ebs_size_in_gb" {
#   type    = number
#   default = 0
# }

variable "tags" {
  type = object({
    environment = string
    product     = string
  })
  validation {
    condition     = contains(["dev", "beta", "prod"], var.tags.environment)
    error_message = "invalid tag values"
  }
}