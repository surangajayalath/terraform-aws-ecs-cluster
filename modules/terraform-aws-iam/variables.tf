variable "account_id" {
  type = string
}

variable "region" {
  type = string
}

variable "kms_key_id" {
  type = string
}

variable "ecs_task_execution_role_name" {
  type = string
}

variable "ecs_task_role_name" {
  type = string
}

variable "secret_manager_path" {
  type = string
}

variable "ecs_task_execution_policy_arn" {
  type = string
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
}