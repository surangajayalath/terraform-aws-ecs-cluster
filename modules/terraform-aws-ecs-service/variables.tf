variable "service_name" {
  type        = string
  description = "Name for ECS Service"
}

variable "cluster_id" {
  type        = string
  description = "Cluster ID for ECS Service"
}

variable "ecs_cluster_launch_type" {
  type        = string
  default     = "FARGATE"
  description = "AWS ECS Launch Types -  Fargate/ECS and External"
}

variable "assign_public_ip" {
  type        = bool
  default     = false
  description = "Enable/Disable Public IP for ECS Services"
}

variable "enable_execute_command" {
  type        = bool
  default     = true
  description = "Enable ECS Service's Container Execution through CLI"
}

variable "task_definition_arn" {
  type        = string
  description = "AWS ECS Task Definition ARN"
}

variable "desired_count" {
  type        = number
  description = "Desired number of Services count"
}

variable "minimum_healthy_percent" {
  type        = string
  description = "Minimum Health Percent for Each Services"
}

variable "maximum_percent" {
  type        = string
  description = "Maximum Health Percent for Each Services"
}

variable "container_security_group_arn" {
  type        = string
  description = "AWS Secuirty Group ARN for Service's Network Configuration"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private Subnet IDs"
}

variable "target_group_arn" {
  type        = string
  description = "AWS Target Group ARN Values to Attach service"
}

variable "container_name" {
  type        = string
  description = "Proper Name ECS Service's Container"
}

variable "container_port" {
  type        = string
  description = "Container Application Expose Port"
}

variable "service_discovery_arn" {
  type        = string
  description = "To Add Inter-Service Communication for each Service"
}

variable "enable_load_balancer" {
  description = "Boolean flag to enable/disable load balancer attachment"
  type        = bool
  default     = false
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