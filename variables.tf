# Network 
variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where resources will be deployed."
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC."
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs within the VPC."
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs within the VPC."
}

# AWS ECS Cluster Service IAM
variable "account_id" {
  type        = string
  description = "The AWS account ID where resources will be created."
}

variable "region" {
  type        = string
  description = "The AWS region where resources will be created."
}

variable "container_sg_name" {
  type        = string
  description = "The name of the security group for the ECS containers."
}

variable "ecs_task_execution_role_name" {
  type        = string
  description = "The name of the IAM role for ECS task execution."
}

variable "ecs_task_role_name" {
  type        = string
  description = "The name of the IAM role for the ECS task."
}

variable "secret_manager_path" {
  type        = string
  description = "The path in AWS Secrets Manager for storing secrets."
}

variable "enable_s3_access_policy" {
  type        = bool
  default     = false
  description = "Flag to enable or disable the S3 access policy."
}

# AWS ECS Cluster
variable "cw_log_group_name" {
  type        = string
  description = "The name of the CloudWatch log group for the ECS cluster."
}

# AWS ECS Cluster Service Task Definition
variable "family_name" {
  type        = string
  description = "The family name for the ECS task definition."
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
  type        = any
  description = "The file path for the container definitions JSON file."
}

# AWS ECS Cluster Service
variable "desired_count" {
  type        = number
  description = "The desired number of ECS service tasks."
}

variable "minimum_healthy_percent" {
  type        = number
  description = "The minimum healthy percent of the service's desired count."
}

variable "maximum_percent" {
  type        = number
  description = "The maximum percent of the service's desired count."
}

variable "container_port" {
  type        = number
  description = "The port number on which the container is listening."
}

variable "service_name" {
  type        = string
  description = "The name of the ECS service."
}

variable "container_name" {
  type        = string
  description = "The name of the container in the ECS task."
}

variable "cloudmap_name" {
  type        = string
  description = "The name of the CloudMap service."
}

variable "service_ds_name" {
  type        = string
  description = "The name of the service discovery service."
}

variable "enable_load_balancer" {
  type        = bool
  default     = true
  description = "Flag to enable or disable the load balancer."
}

# AWS ECS Cluster Service's Target Group
variable "target_group_name" {
  type        = string
  description = "The name of the target group for the ECS service."
}

variable "target_group_port" {
  type        = string
  description = "The port number for the target group."
}

variable "routing_path" {
  type        = string
  description = "The routing path for the target group."
}

variable "health_check_path" {
  type        = string
  description = "The health check path for the target group."
}

variable "alb_listner_priority" {
  type        = number
  description = "The priority for the ALB listener rule."
}

variable "alb_https_listener_arn" {
  type        = string
  description = "HTTPS Listner ARN"
}

variable "api_domain_name" {
  type        = string
  description = "The domain name for the API."
}

variable "kms_key_alias" {
  type        = string
  description = "The alias for the KMS key."
}

variable "cluster_name" {
  type        = string
  description = "The name of the ECS cluster."
}

# variable "listner_priority" {
#   type        = number
#   description = "The priority for the listener."
# }

variable "root_hosted_zone_id" {
  type        = string
  description = "The ID of the root hosted zone."
}

variable "api_domain_name_prefix" {
  type        = string
  description = "The prefix for the API domain name."
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
