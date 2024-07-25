# AWS Elastic Container Service (ECS) Terraform module

Terraform module which creates ECS resources on AWS.

This module focuses purely on ECS and Related services. Therefore only these resources can be created with this module:

- IAM Permissions

Usage
```
module "nginx_service_iam" {
  source                       = "./modules/terraform-aws-iam"
  account_id                   = var.account_id
  region                       = var.region
  ecs_task_execution_role_name = "nginx-task-execution-role"
  ecs_task_role_name           = "nginx-task-role"
  kms_key_id                   = aws_kms_key.master_kms_key.key_id
  secret_manager_path          = "nginx/service/beta-rXvtzO"
  enable_s3_access_policy      = false
}
```
