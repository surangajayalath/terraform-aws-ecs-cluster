resource "aws_kms_key" "master_kms_key" {
  description             = "Master key for all ecs resources"
  deletion_window_in_days = 7
  tags                    = var.tags
  enable_key_rotation     = true
}

resource "aws_kms_alias" "master_kms_key_alias" {
  name          = var.kms_key_alias
  target_key_id = aws_kms_key.master_kms_key.key_id
}

resource "aws_kms_key_policy" "key_policy" {
  key_id = aws_kms_key.master_kms_key.key_id
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "kms_policy"
    Statement = [
      {
        Action = "kms:*"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.account_id}:root"
        }

        Resource = "*"
        Sid      = "Enable IAM User Permissions"
      },
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "logs.${var.region}.amazonaws.com"
        },
        "Action" : [
          "kms:Encrypt*",
          "kms:Decrypt*",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:Describe*"
        ],
        "Resource" : "*",
        "Condition" : {
          "ArnEquals" : {
            "kms:EncryptionContext:aws:logs:arn" : "arn:aws:logs:${var.region}:${var.account_id}:log-group:nginx/ecs/cluster/*"
          }
        }
      }
    ]
  })
}
