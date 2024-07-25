data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["scheduler.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "allow_update_service" {
  statement {
    actions   = ["ecs:UpdateService"]
    resources = ["*"]
  }
}

resource "aws_iam_role" "scheduler" {
  name               = "${var.scheduler_name}-scheduler-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "allow_update_service" {
  role       = aws_iam_role.scheduler.name
  policy     = data.aws_iam_policy_document.allow_update_service.json
  depends_on = [aws_iam_role.scheduler]
}

resource "aws_scheduler_schedule" "turn_off" {
  name                         = "${var.scheduler_name}-turn-off"
  schedule_expression_timezone = var.schedule_expression_timezone
  schedule_expression          = var.turn_off_schedule_expression

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:ecs:updateService"
    role_arn = aws_iam_role.scheduler.arn

    input = jsonencode({
      Cluster      = var.ecs_cluster_name
      Service      = var.ecs_service_name
      DesiredCount = var.scale_down_count
    })
  }

  flexible_time_window {
    mode = "OFF"
  }
}

resource "aws_scheduler_schedule" "turn_on" {
  name                         = "${var.scheduler_name}-turn-on"
  schedule_expression_timezone = var.schedule_expression_timezone
  schedule_expression          = var.turn_on_schedule_expression

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:ecs:updateService"
    role_arn = aws_iam_role.scheduler.arn

    input = jsonencode({
      Cluster      = var.ecs_cluster_name
      Service      = var.ecs_service_name
      DesiredCount = var.scale_up_count
    })
  }

  flexible_time_window {
    mode = "OFF"
  }
}