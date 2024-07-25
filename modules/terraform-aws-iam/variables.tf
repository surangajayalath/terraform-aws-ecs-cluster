variable "account_id" {
  type = string
  description = "AWS Account ID"
}

variable "region" {
  type = string
  description = "AWS Region Name"
}

variable "kms_key_id" {
  type = string
  default = "KMS Key ID for Encryptions"
}

variable "ecs_task_execution_role_name" {
  type = string
  description = "AWS ECS Task Execution Role Name"
}

variable "ecs_task_role_name" {
  type = string
  description = "AWS ECS Task Role Name"
}

variable "secret_manager_path" {
  type = string
  default = "AWS Secret Manager Path to Grant Access Permission to the IAM Role"
}

variable "ecs_task_execution_policy_arn" {
  type = string
  description = "AWS Managed Task Execution Role Policy"
  default = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

variable "enable_s3_access_policy" {
  description = "Boolean flag to enable/disable s3 policy"
  type        = bool
  default     = false
}

variable "s3_bucket_names" {
  type    = list(string)
  default = []
  description = "AWS S3 Bucket name to Grant Access Permission to the IAM Role"
}