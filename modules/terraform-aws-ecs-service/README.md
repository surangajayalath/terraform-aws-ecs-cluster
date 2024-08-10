# AWS Elastic Container Service (ECS) Terraform module

Terraform module which creates ECS Service on AWS ECS Cluster.

- AWS ECS Services

Usage
```module "nginx_service" {
  source                      = "./modules/terraform-aws-ecs-service"

  desired_count               = 2
  minimum_healthy_percent     = 50
  maximum_percent             = 100
  container_port              = 8080
  service_name                = "nginx-service"
  container_name              = "nginx-service-container"
  cluster_id                  = "arn:aws:ecs:region:aws_account_id:task/task-id"
  private_subnet_ids          = ["subnet-5678a851de5eexxxx"]
  task_definition_arn         = "arn:aws:ecs:{region}:{account-id}:task-definition/fargate-task-name:revision-id"
  container_security_group_id = ["sg-0abcdef1234567890"]
  service_discovery_arn       = "arn:aws:servicediscovery:{region}:{account-id}:namespace/ns-e3wpefgeejg6kftr"
  enable_load_balancer        = true
  target_group_arn            = "arn:aws:elasticloadbalancing:{region}:{accound-id}:targetgroup/{target-group-id"

  tags                        = { 
    environment = "beta" 
  }
}
```

### Explanation
- **source:** Specifies the source of the module. Here, it is a local module path (./modules/terraform-aws-ecs-service).
- **desired_count:** Sets the desired number of tasks to run in the service (1).
- **minimum_healthy_percent:** Defines the minimum number of tasks that must be healthy for the service to be considered healthy during a deployment (0).
- **maximum_percent:** Determines the maximum percentage of the desired number of tasks that can be running during a deployment (100).
- **container_port:** Specifies the port on which the container listens for traffic (8080).
- **service_name:** Sets the name of the ECS service (nginx_service).
- **container_name:** Defines the name of the container within the service (nginx_service_container).
- **cluster_id:** Provides the ID of the ECS cluster in which to create the service, obtained from the ECS cluster module (module.ecs-cluster.cluster_id).
- **private_subnet_ids:** Lists the private subnet IDs for the service, obtained from a variable (var.private_subnet_ids).
- **task_definition_arn:** Specifies the ARN of the task definition to use for tasks in the service, obtained from the task definition module (module.nginx_service_td.task_definition_arn).
- **container_security_group_id:** Lists the security group IDs to associate with the ECS service's containers ([aws_security_group.ecs_container_sg.id]).
- **service_discovery_arn:** Provides the ARN of the service discovery service for the ECS service (aws_service_discovery_service.nginx_service_ds.arn).
- **enable_load_balancer:** Flag to enable or disable the integration with a load balancer (true).
- **target_group_arn:** Specifies the ARN of the target group to associate with the ECS service, obtained from the target group module (module.nginx_service_tg.tg_arn).
- **tags:** Assigns tags to the ECS service, in this case, tagging the environment as "beta" ({ environment = "beta" }).

This module configuration allows you to set up an ECS service with necessary attributes, making it easy to deploy and manage containerized applications on AWS.