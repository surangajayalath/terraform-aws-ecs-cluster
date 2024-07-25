output "target_group_arn" {
  value = module.nginx_service_tg.tg_arn
}

output "ecs_cluster_id" {
  value = module.ecs-cluster.cluster_id
}

output "ecs_cluster_name" {
  value = module.ecs-cluster.cluster_name
}

output "ecs_service_name" {
  value = module.nginx_service.service_name
}

output "task_definition_arn" {
  value = module.nginx_service_td.task_definition_arn
}

output "task_execution_role_arn" {
  value = module.nginx_service_iam.ecs_task_execution_role_arn
}

output "ecs_task_role_arn" {
  value = module.nginx_service_iam.ecs_task_role_arn
}