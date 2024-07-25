resource "aws_ecs_service" "service" {
  name                               = var.service_name
  cluster                            = var.cluster_id
  task_definition                    = var.task_definition_arn
  desired_count                      = var.desired_count
  deployment_minimum_healthy_percent = var.minimum_healthy_percent
  deployment_maximum_percent         = var.maximum_percent
  launch_type                        = var.ecs_cluster_launch_type
  enable_execute_command             = var.enable_execute_command

  deployment_controller {
    type = "ECS"
  }

  network_configuration {
    security_groups  = var.container_security_group
    subnets          = var.private_subnet_ids
    assign_public_ip = var.assign_public_ip
  }

  # AWS Application Load Balancer configuration
  dynamic "load_balancer" {
    for_each = var.enable_load_balancer ? [1] : []
    content {
      target_group_arn = var.target_group_arn
      container_name   = var.container_name
      container_port   = var.container_port
    }
  }

  # AWS ECS Inter-service Communication using "Service discovery" method
  service_registries {
    registry_arn   = var.service_discovery_arn
    container_name = var.container_name
  }

  tags = var.tags
}