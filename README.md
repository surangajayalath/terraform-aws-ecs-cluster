# AWS Elastic Container Service (ECS) Terraform module

Terraform module which creates ECS resources on AWS.

This module focuses purely on ECS and Related services. Therefore only these resources can be created with this module:

- IAM Permissions
- ECS Cluster
- AWS ECS Task Definitions
- AWS ECS Services
- AWS Target Groups

Usage
```
#########################################################################
# AWS ECS Cluster
#########################################################################
module "ecs-cluster" {
  source            = "surangajayalath/ecs-cluster/aws"
  version           = "1.0.0"
  cluster_name      = "aws-ecs-cluster"
  cw_log_group_name = "nginx/ecs/cluster"
  kms_key_id        = aws_kms_key.master_kms_key.arn
  tags              = { 
    environment = "dev" 
  }
}
```
