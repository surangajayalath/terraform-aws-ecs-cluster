resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = var.cw_log_group_name
  retention_in_days = "7"
  tags              = var.tags
  kms_key_id        = var.kms_key_id
}