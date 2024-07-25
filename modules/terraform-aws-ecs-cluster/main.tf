resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name
  tags = var.tags

  setting {
    name  = "containerInsights"
    value = var.container_insight_enable
  }

  configuration {
    execute_command_configuration {
      kms_key_id = var.kms_key_id
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.ecs_log_group.name
      }
    }
  }
}