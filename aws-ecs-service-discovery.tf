############## AWS Cloud Map #######
resource "aws_service_discovery_private_dns_namespace" "service_ns" {
  name        = "local.dev"
  description = "ECS Service Discover for Inter Service Communications"
  vpc         = var.vpc_id
}

############# Attach Cloud Map and Configure ECS Service ###########
resource "aws_service_discovery_service" "nginx_service_ds" {
  name = "nginx.service"
  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.service_ns.id
    dns_records {
      ttl  = 300
      type = "A"
    }
    routing_policy = "MULTIVALUE"
  }
  health_check_custom_config {
    failure_threshold = 1
  }
}