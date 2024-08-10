# AWS Elastic Container Service (ECS) Terraform module

Terraform module will create IAM roles for ECS Services.

- IAM Permissions

Usage
```
module "nginx_service_iam" {
  source                       = "./modules/terraform-aws-iam"

  account_id                   = var.account_id
  region                       = "us-west-2"
  ecs_task_execution_role_name = "nginx-task-execution-role"
  ecs_task_role_name           = "nginx-task-role"
  kms_key_id                   = "arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"
  secret_manager_path          = "nginx/service/beta-rXvtzO"
  enable_s3_access_policy      = false

  tags                         = { 
    environment = "beta" 
  }
}
```

Explanation

- **source:** Specifies the source of the module. Here, it is a local module path (./modules/terraform-aws-iam).
- **account_id:** Provides the AWS account ID where the resources are created, obtained from a variable (var.account_id).
- **region:** Specifies the AWS region where the resources are created, obtained from a variable (var.region).
- **ecs_task_execution_role_name:** Sets the name of the IAM role for ECS task execution (nginx-task-execution-role).
- **ecs_task_role_name:** Defines the name of the IAM role for the ECS task (nginx-task-role).
- **kms_key_id:** Provides the ID of the KMS key for encrypting secrets, obtained from the KMS key resource (aws_kms_key.master_kms_key.key_id).
- **secret_manager_path:** Specifies the path in AWS Secrets Manager for storing secrets (nginx/service/beta-rXvtzO).
- **enable_s3_access_policy:** Flag to enable or disable the S3 access policy (false).

This module configuration allows you to set up IAM roles and permissions necessary for ECS tasks, ensuring secure and efficient management of resources and secrets on AWS.






