variable "family_name" {
  type        = string
  description = "The family name for the ECS task definition."
}

variable "task_execution_role_arn" {
  type        = string
  description = "The ARN of the IAM role for ECS task execution."
}

variable "task_role_arn" {
  type        = string
  description = "The ARN of the IAM role for the ECS task."
}

variable "task_cpu" {
  type        = number
  description = "The amount of CPU units to allocate for the task."
}

variable "task_memory" {
  type        = number
  description = "The amount of memory (in MiB) to allocate for the task."
}

variable "container_definitions_file_path" {
  type        = string
  description = "The file path for the container definitions JSON file."
}

variable "network_mode" {
  type        = string
  default     = "awsvpc"
  description = "The network mode for the ECS task (default: 'awsvpc')."
}

variable "requires_compatibilities" {
  type        = list(string)
  default     = ["FARGATE"]
  description = "The launch types required by the task definition (default: ['FARGATE'])."
}

variable "tags" {
  type = object({
    environment = string
  })
  validation {
    condition     = contains(["dev", "beta", "prod"], var.tags.environment)
    error_message = "Invalid environment tag value. Must be 'dev', 'beta', or 'prod'."
  }
  description = "Tags for the resources, based on the environment (dev, beta, prod)."
}
