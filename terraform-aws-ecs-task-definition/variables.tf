variable "family_name" {
  type = string
}

variable "task_execution_role_arn" {
  type = string
}

variable "task_role_arn" {
  type = string
}

variable "task_cpu" {
  type = number
}

variable "task_memory" {
  type = number 
}

variable "container_definitions_file_path" {
  type = string
}

variable "network_mode" {
  type = string
  default = "awsvpc"
}

variable "requires_compatibilitiesty" {
  type = list(string)
  default     = ["FARGATE"]
}

# variable "enable_volume_mount" {
#   type        = bool
#   default     = false
# }

# variable "volume_name" {
#   type = string
#   default = ""
# }

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