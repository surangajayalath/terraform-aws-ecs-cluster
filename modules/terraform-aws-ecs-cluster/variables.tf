variable "cluster_name" {
  type = string
}

variable "container_insight_enable" {
  type = string
  default = "enabled"
}

variable "kms_key_id" {
  type = string
}

variable "cw_log_group_name" {
  type = string
}

variable "tags" {
  type = object({
    environment = string
  })
  validation {
    condition     = contains(["dev", "beta", "prod"], var.tags.environment)
    error_message = "Invalid env tag value.."
  }
}