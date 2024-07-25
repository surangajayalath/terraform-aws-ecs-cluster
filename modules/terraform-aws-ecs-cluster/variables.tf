variable "cluster_name" {
  type        = string
  description = "Name for ECS Cluster"
}

variable "container_insight_enable" {
  type        = string
  default     = "enabled"
  description = "Enable ECS Cluster Container Insights"
}

variable "kms_key_id" {
  type        = string
  description = "AWS KMS ID for Encryptions"
}

variable "cw_log_group_name" {
  type        = string
  description = "Cloud Watch Group Name for ECS Cluster logs"
}

variable "tags" {
  type = object({
    environment = string
  })
  validation {
    condition     = contains(["dev", "beta", "prod"], var.tags.environment)
    error_message = "Invalid env tag value.."
  }
  description = "Tag Values based on the Different Environmets"
}