# AWS Elastic Container Service (ECS) Terraform module

Terraform module which creates ECS resources on AWS.

This module focuses purely on ECS and Related services. Therefore only these resources can be created with this module:

- AWS ECS Services


Usage
```module "nginx_service" {
  source                      = "./modules/terraform-aws-ecs-service"
  desired_count               = 1
  minimum_healthy_percent     = 0
  maximum_percent             = 100
  container_port              = 8080
  service_name                = "nginx_service"
  container_name              = "nginx_service_container"
  cluster_id                  = module.ecs-cluster.cluster_id
  private_subnet_ids          = var.private_subnet_ids
  task_definition_arn         = module.nginx_service_td.task_definition_arn
  container_security_group_id = [aws_security_group.ecs_container_sg.id]
  service_discovery_arn       = aws_service_discovery_service.nginx_service_ds.arn
  enable_load_balancer        = true
  target_group_arn            = module.nginx_service_tg.tg_arn
  tags                        = { environment = "beta" }
}
```
