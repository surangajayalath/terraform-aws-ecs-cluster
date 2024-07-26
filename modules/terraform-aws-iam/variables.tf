variable "account_id" {
  type        = string
  description = "AWS Account ID."
}

variable "region" {
  type        = string
  description = "AWS Region name."
}

variable "kms_key_id" {
  type        = string
  description = "KMS Key ID for encryptions."
}

variable "ecs_task_execution_role_name" {
  type        = string
  description = "Name of the AWS ECS task execution role."
}

variable "ecs_task_role_name" {
  type        = string
  description = "Name of the AWS ECS task role."
}

variable "secret_manager_path" {
  type        = string
  description = "Path in AWS Secrets Manager to grant access permission to the IAM role."
}

variable "ecs_task_execution_policy_arn" {
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  description = "ARN of the AWS managed task execution role policy."
}

variable "enable_s3_access_policy" {
  type        = bool
  default     = false
  description = "Boolean flag to enable or disable S3 access policy."
}

variable "s3_bucket_names" {
  type        = list(string)
  default     = []
  description = "List of AWS S3 bucket names to grant access permission to the IAM role."
}
