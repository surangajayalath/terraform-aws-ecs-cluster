output "service_name" {
  value       = aws_ecs_service.service.name
  description = "ECS Service Name"
}