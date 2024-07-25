# AWS Elastic Container Service (ECS) Terraform module

Terraform module which creates ECS resources on AWS.

This module focuses purely on ECS and Related services. Therefore only these resources can be created with this module:

- AWS EventBrige Schedules

Usage
```
module "nginx_service_scheduler" {
  source                       = "./modules/terraform-aws-eventbridge-scheduler"
  scheduler_name               = "nginx-service"
  turn_on_schedule_expression  = "cron(0 8 ? * MON,TUE,WED,THU,FRI *)"
  turn_off_schedule_expression = "cron(0 22 ? * MON,TUE,WED,THU,FRI *)"
  ecs_cluster_name             = module.ecs-cluster.cluster_name
  ecs_service_name             = module.nginx_service.service_name
}
```
