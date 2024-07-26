variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where resources will be deployed."
}

variable "service_name" {
  type        = string
  description = "The name of the ECS service."
}

variable "cluster_id" {
  type        = string
  description = "The ID of the ECS cluster."
}

variable "ecs_cluster_launch_type" {
  type        = string
  default     = "FARGATE"
  description = "The launch type for the ECS cluster (FARGATE, ECS, or EXTERNAL)."
}

variable "assign_public_ip" {
  type        = bool
  default     = false
  description = "Whether to assign a public IP to the ECS service."
}

variable "enable_execute_command" {
  type        = bool
  default     = true
  description = "Whether to enable ECS service's container execution through CLI."
}

variable "task_definition_arn" {
  type        = string
  description = "The ARN of the AWS ECS task definition."
}

variable "desired_count" {
  type        = number
  description = "The desired number of ECS service instances."
}

variable "minimum_healthy_percent" {
  type        = string
  description = "The minimum healthy percent of the ECS service."
}

variable "maximum_percent" {
  type        = string
  description = "The maximum percent of the ECS service."
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "The list of private subnet IDs."
}

variable "target_group_arn" {
  type        = string
  description = "The ARN of the AWS target group to attach the service."
}

variable "container_name" {
  type        = string
  description = "The name of the container in the ECS service."
}

variable "container_port" {
  type        = string
  description = "The port on which the container application is exposed."
}

variable "service_discovery_arn" {
  type        = string
  description = "The ARN for service discovery to enable inter-service communication."
}

variable "enable_load_balancer" {
  type        = bool
  default     = false
  description = "Whether to enable load balancer attachment for the service."
}

variable "container_sg_name" {
  type        = string
  description = "The name of the security group for the container."
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
