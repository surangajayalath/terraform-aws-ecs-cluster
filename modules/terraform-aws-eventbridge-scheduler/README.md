# AWS Elastic Container Service (ECS) Terraform module

Terraform module which creates AWS EventBridge schedules to scale up/down services during specific times. This helps in reducing costs by scaling services according to usage patterns.

Resources Created
- AWS EventBridge Schedules

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

Explanation

- **source:** Specifies the source of the module. Here, it is a local module path (./modules/terraform-aws-eventbridge-scheduler).
- **scheduler_name:** Sets the name of the scheduler (nginx-service).
- **turn_on_schedule_expression:** Defines the cron expression for the schedule to turn on the service (cron(0 8 ? * MON,TUE,WED,THU,FRI *)).
- **turn_off_schedule_expression:** Sets the cron expression for the schedule to turn off the service (cron(0 22 ? * MON,TUE,WED,THU,FRI *)).
- **ecs_cluster_name:** Provides the name of the ECS cluster where the service is running, obtained from the ECS cluster module (module.ecs-cluster.cluster_name).
- **ecs_service_name:** Specifies the name of the ECS service to be scheduled, obtained from the ECS service module (module.nginx_service.service_name).

This module configuration allows you to set up schedules using AWS EventBridge to automatically scale your ECS services up and down according to specified times, optimizing resource usage and reducing costs.