variable "scheduler_name" {
  type        = string
  description = "Schduler Name Based on the Application Running on the Cluster"
}

variable "turn_on_schedule_expression" {
  type        = string
  description = "CRON Expression for Scale Up ECS Service"
}

variable "turn_off_schedule_expression" {
  type        = string
  description = "CRON Expression for scale Down ECS Srvice"
}

variable "ecs_cluster_name" {
  type        = string
  description = "AWS ECS Cluster Name"
}

variable "ecs_service_name" {
  type        = string
  description = "AWS ECS Service Name"
}

variable "schedule_expression_timezone" {
  type        = string
  default     = "Asia/Colombo"
  description = "Timezone Based on the location"
}

variable "scale_up_count" {
  type        = number
  default     = 1
  description = "Scale Up Count for Scheduler"
}

variable "scale_down_count" {
  type        = number
  default     = 0
  description = "Scale Down Count for Scheduler"
}

