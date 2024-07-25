resource "aws_iam_role" "ecs_task_execution_role" {
  name = var.ecs_task_execution_role_name
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "ecs-tasks.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
    }
  )

# log groups create policy
  inline_policy {
    name = "${var.ecs_task_execution_role_name}-cloudwatch"
    policy = jsonencode({
      Version = "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : ["logs:CreateLogGroup"],
          "Resource" : "*"
        }
      ]
    })
  }

# secret manager access policy
  inline_policy {
    name = "${var.ecs_task_execution_role_name}-secret-manager"
    policy = jsonencode({
      Version = "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : ["secretsmanager:GetSecretValue"],
          "Resource" : "arn:aws:secretsmanager:${var.region}:${var.account_id}:secret:${var.secret_manager_path}*"
        },
        {
          Action = ["kms:Decrypt"]
          Effect = "Allow"
          Resource = [
            "arn:aws:kms:${var.region}:${var.account_id}:key/${var.kms_key_id}"
          ]
        }
      ]
    })
  }
}

# ecs task execution policy
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = var.ecs_task_execution_policy_arn
}

resource "aws_iam_role" "ecs_task_role" {
  name = var.ecs_task_role_name
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "ecs-tasks.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
    }
  )

# s3 access policy
    dynamic "inline_policy" {
    for_each = var.enable_s3_access_policy ? [1] : []
    content {
      name = "${var.ecs_task_role_name}-s3"
      policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
          for bucket in var.s3_bucket_names : {
            Effect   = "Allow"
            Action   = ["s3:PutObject", "s3:PutObjectAcl", "s3:GetObject"]
            Resource = "arn:aws:s3:::${bucket}/*"
          }
        ]
      })
    }
  }

# AWS KMS access policy
  inline_policy {
    name = "${var.ecs_task_role_name}-kms"
    policy = jsonencode({
      Version = "2012-10-17",
      "Statement" : [
        {
          Action = ["kms:GenerateDataKey","kms:Decrypt"]
          Effect = "Allow"
          Resource = [
            "arn:aws:kms:${var.region}:${var.account_id}:key/*"
          ]
        }
      ]
    })
  }

# permission to exec ecs container from aws cli
  inline_policy {
    name = "${var.ecs_task_role_name}-cw-ssm-policy"
    policy = jsonencode({
      Version = "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "ssmmessages:CreateControlChannel",
            "ssmmessages:CreateDataChannel",
            "ssmmessages:OpenControlChannel",
            "ssmmessages:OpenDataChannel",
          ],
          "Resource" : "*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "logs:DescribeLogGroups",
            "logs:GetLogEvents",
            "logs:FilterLogEvents",
          ],
          "Resource" : "*"
        },
        {
          "Effect" : "Allow",
          "Action" : "kms:Decrypt"
          "Resource" : "arn:aws:kms:${var.region}:${var.account_id}:key/${var.kms_key_id}"
        }
      ]
    })
  }
}

