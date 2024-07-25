# AWS Elastic Container Service (ECS) Terraform module

Terraform module which creates ECS resources on AWS.

This module focuses purely on ECS and Related services. Therefore only these resources can be created with this module:

- ECS Cluster
- IAM Permissions
- AWS Target Groups
- AWS ECS Services
- AWS ECS Task Definitions
- AWS EventBrige Schedules

Usage
```
module "ecs" {
  source  = "surangajayalath/ecs-cluster/aws/tree/v1.0.0/"
  version = "1.0.0"
  account_id        = var.account_id
  region            = var.region
  cluster_name      = var.cluster_name
  cw_log_group_name = var.cloudwatch_log_group_name
  kms_key_id        = aws_kms_key.master_kms_key.arn
  tags              = var.tags
}
```
