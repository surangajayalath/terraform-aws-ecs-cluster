output "cluster_id" {
  value       = aws_ecs_cluster.ecs_cluster.id
  description = "AWS ECS Cluster ID"
}

output "cluster_name" {
  value       = aws_ecs_cluster.ecs_cluster.name
  description = "AWS ECS Cluster Name"
}