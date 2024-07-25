variable "scheduler_name" {
  type = string
}

variable "turn_on_schedule_expression" {
  type = string
}

variable "turn_off_schedule_expression" {
  type = string
}

variable "ecs_cluster_name" {
  type = string
}

variable "ecs_service_name" {
  type = string
}

variable "schedule_expression_timezone" {
  type = string
  default = "Asia/Colombo"
}

variable "scale_up_count" {
  type = number
  default = 1
}

variable "scale_down_count" {
  type = number
  default = 0
}

