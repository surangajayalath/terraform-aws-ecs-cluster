# AWS Elastic Container Service (ECS) Terraform Module

This module will create task definition for ECS service deployments.

- AWS ECS Task Definitions

Usage
```
module "nginx_service_td" {
  source                          = "./modules/terraform-aws-ecs-task-definition"

  family_name                     = "nginx-service-td"
  task_execution_role_arn         = "arn:aws:iam::{account-id}:role/nginx-task-execution-role"
  task_role_arn                   = "arn:aws:iam::{account-id}:role/nginx-task-role"
  task_cpu                        = 256
  task_memory                     = 512
  container_definitions_file_path = file("ecs-task-definition/nginx-service-td.json")

  tags                        = { 
    environment = "beta" 
  }
}
```

Explanation

- **source:** Specifies the source of the module. Here, it is a local module path (./modules/terraform-aws-ecs-task-definition).
- **family_name:** Sets the family name of the task definition (nginx-service-td).
- **task_execution_role_arn:** Provides the ARN of the IAM role that grants the ECS service permission to make calls to AWS services, obtained from the IAM module (module.nginx_service_iam.ecs_task_execution_role_arn).
- **task_role_arn:** Specifies the ARN of the IAM role that grants permissions to the ECS task, obtained from the IAM module (module.nginx_service_iam.ecs_task_role_arn).
- **task_cpu:** Defines the number of CPU units used by the task (256).
- **task_memory:** Sets the amount of memory (in MiB) used by the task (512).
- **tags:** Assigns tags to the ECS task definition, in this case, tagging the environment as "beta" ({ environment = "beta" }).
- **container_definitions_file_path:** Specifies the path to the file containing the container definitions in JSON format, using the file function to read the file (file("ecs-task-definition/nginx-service-td.json")).

This module configuration enables you to create ECS task definitions with the necessary attributes, making it easy to define and manage containerized tasks on AWS.