variable "account_id" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "kms_key_alias" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "cluster_name" {
  type = string
}

variable "nginx_service_listner_priority" {
  type = number
}

variable "root_hosted_zone_id" {
  type = string
}

variable "api_domain_name" {
  type = string
}

variable "api_domain_name_prefix" {
  type = string
}

variable "branch_name" {
  type = string
}

variable "tags" {
  type = object({
    environment = string
  })

  validation {
    condition     = contains(["beta", "prod", "staging"], var.tags.environment)
    error_message = "invalid Environment tag values"
  }
}