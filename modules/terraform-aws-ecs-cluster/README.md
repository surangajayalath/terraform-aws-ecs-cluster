# AWS Elastic Container Service (ECS) Terraform module

Terraform module which creates ECS Cluster on AWS.

- ECS Cluster

Usage
```
module "ecs-cluster" {
  source            = "./modules/terraform-aws-ecs-cluster"

  cluster_name      = "aws-ecs-cluster"
  cw_log_group_name = "nginx/ecs/cluster"
  kms_key_id        = "arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"
  tags              = { 
    environment = "beta"
  }
}
```

### Explanation

- **source:** Specifies the source of the module. Here, it is a local module path (./modules/terraform-aws-ecs-cluster).
- **cluster_name:** Sets the name of the ECS cluster, obtained from a variable (var.cluster_name).
- **cw_log_group_name:** Defines the name of the CloudWatch Log Group for ECS logs (nginx/ecs/cluster).
- **kms_key_id:** Provides the ARN of the KMS key used for encrypting ECS logs, obtained from the KMS key resource (aws_kms_key.master_kms_key.arn).
- **tags:** Assigns tags to the ECS cluster, obtained from a variable (var.tags).

This module configuration enables you to set up an ECS cluster with necessary logging and encryption features, making it easy to manage and secure your ECS resources.