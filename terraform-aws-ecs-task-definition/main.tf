resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.family_name
  network_mode             = var.network_mode
  requires_compatibilities = var.requires_compatibilitiesty
  execution_role_arn       = var.task_execution_role_arn
  task_role_arn            = var.task_role_arn
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  tags                     = var.tags
  container_definitions    = var.container_definitions_file_path
}

