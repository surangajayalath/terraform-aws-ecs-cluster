variable "cluster_name" {
  type        = string
  description = "Name for the ECS cluster."
}

variable "container_insight_enable" {
  type        = string
  default     = "enabled"
  description = "Enable ECS cluster container insights."
}

variable "kms_key_id" {
  type        = string
  description = "AWS KMS ID for encryptions."
}

variable "cw_log_group_name" {
  type        = string
  description = "CloudWatch log group name for ECS cluster logs."
}

variable "cw_retention_in_days" {
  type        = string
  default     = "7"
  description = "CloudWatch log group retention period"
}

variable "tags" {
  type = object({
    environment = string
  })
  validation {
    condition     = contains(["dev", "beta", "prod"], var.tags.environment)
    error_message = "Invalid environment tag value. Must be 'dev', 'beta', or 'prod'."
  }
  description = "Tag values based on the different environments (dev, beta, prod)."
}
