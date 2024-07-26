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
    security_groups  = [aws_security_group.container_sg.id]
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

resource "aws_security_group" "container_sg" {
  name        = var.container_sg_name
  description = "Security group for ECS task running on Fargate"
  vpc_id      = var.vpc_id
  tags        = var.tags

  ingress {
    description = "Allow all ingress traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all egress traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}