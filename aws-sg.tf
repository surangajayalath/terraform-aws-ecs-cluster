resource "aws_security_group" "ecs_container_sg" {
  name        = "ecs-service-containers-sg"
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