# AWS Elastic Container Service (ECS) Terraform module

This module creates a target group based on the AWS ECS deployed services.

- AWS Target Group

Usage
```
module "anomaly_service_tg" {
  source                 = "surangajayalath/ecs-cluster/aws//modules/terraform-aws-alb-tg"
  version                = "1.0.2"
  target_group_name      = "ecs-nginx-service-tg-${terraform.workspace}"
  target_group_port      = 3000
  routing_path           = "/api/nginxservice"
  health_check_path      = "/api/nginxservice/healthcheck"
  alb_https_listener_arn = local.alb_external_https_listener_arn
  alb_listner_priority   = 90
  domain_name            = "api.example.com
  vpc_id                 = var.vpc_id
  tags                   = tags = { environment = "beta" }
}
```

### Explanation

- **source:** Specifies the source of the module, including the provider (surangajayalath/ecs-cluster/aws) and the specific module path (modules/terraform-aws-alb-tg).
- **version:** Indicates the version of the module to use (1.0.2).
- **target_group_name:** Sets the name of the target group, appending the Terraform workspace to ensure uniqueness across different environments.
- **target_group_port:** Defines the port on which the target group listens for traffic (3000).
- **routing_path:** Specifies the path pattern for routing traffic to the target group (/api/nginxservice).
- **health_check_path:** Sets the path used for health checks to determine the health of the targets (/api/nginxservice/healthcheck).
- **alb_https_listener_arn:** Provides the ARN of the ALB HTTPS listener to associate with this target group, obtained from a local value (local.alb_external_https_listener_arn).
- **alb_listner_priority:** Determines the priority of the rule in the listener (90).
- **domain_name:** Specifies the domain name for the service (api.example.com).
- **vpc_id:** Indicates the ID of the VPC in which the target group is created, obtained from a variable (var.vpc_id).
- **tags:** Assigns tags to the target group, in this case, tagging the environment as "beta".

This module configuration allows you to set up an ECS service with a target group that is correctly integrated with an ALB, providing routing and health check capabilities.
