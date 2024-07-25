# AWS Elastic Container Service (ECS) Terraform module

Terraform module which creates ECS resources on AWS.

This module focuses purely on ECS and Related services. Therefore only these resources can be created with this module:

- ECS Cluster

Usage
```
module "ecs-cluster" {
  source            = "./modules/terraform-aws-ecs-cluster"
  cluster_name      = var.cluster_name
  cw_log_group_name = "nginx/ecs/cluster"
  kms_key_id        = aws_kms_key.master_kms_key.arn
  tags              = var.tags
}
```
