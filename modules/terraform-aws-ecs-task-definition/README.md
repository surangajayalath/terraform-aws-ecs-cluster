# AWS Elastic Container Service (ECS) Terraform module

Terraform module which creates ECS resources on AWS.

This module focuses purely on ECS and Related services. Therefore only these resources can be created with this module:

- AWS ECS Task Definitions


Usage
```
module "nginx_service_td" {
  source                          = "./modules/terraform-aws-ecs-task-definition"
  family_name                     = "nginx-service-td"
  task_execution_role_arn         = module.nginx_service_iam.ecs_task_execution_role_arn
  task_role_arn                   = module.nginx_service_iam.ecs_task_role_arn
  task_cpu                        = 256
  task_memory                     = 512
  tags                            = { environment = "beta" }
  container_definitions_file_path = file("ecs-task-definition/nginx-service-td.json")
}
```
