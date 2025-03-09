```
#########################################################################
# AWS ECS Cluster Service IAM
#########################################################################
module "iam" {
  source                       = "surangajayalath/ecs-cluster/aws//modules/terraform-aws-iam"
  version                      = "1.0.0"
  account_id                   = var.account_id
  region                       = var.region
  ecs_task_execution_role_name = var.ecs_task_execution_role_name
  ecs_task_role_name           = var.ecs_task_role_name
  kms_key_id                   = aws_kms_key.master_kms_key.key_id
  secret_manager_path          = var.secret_manager_path
  enable_s3_access_policy      = var.enable_s3_access_policy
}

#########################################################################
# AWS ECS Cluster
#########################################################################
module "cluster" {
  source            = "surangajayalath/ecs-cluster/aws"
  version           = "1.0.0"
  cluster_name      = var.cluster_name
  cw_log_group_name = var.cw_log_group_name
  kms_key_id        = aws_kms_key.master_kms_key.key_id
  tags              = var.tags
}

#########################################################################
# AWS ECS Cluster Service Task Definition
#########################################################################
module "td" {
  source                          = "surangajayalath/ecs-cluster/aws//modules/terraform-aws-ecs-task-definition"
  version                         = "1.0.0"
  family_name                     = var.family_name
  task_execution_role_arn         = module.iam.ecs_task_execution_role_arn
  task_role_arn                   = module.iam.ecs_task_role_arn
  task_cpu                        = var.task_cpu
  task_memory                     = var.task_memory
  tags                            = var.tags
  container_definitions_file_path = file(var.container_definitions_file_path)
}

#########################################################################
# AWS ECS Cluster Service
#########################################################################
module "service" {
  source                  = "surangajayalath/ecs-cluster/aws//modules/terraform-aws-ecs-service"
  version                 = "1.0.0"
  vpc_id                  = var.vpc_id
  container_sg_name       = var.container_sg_name
  desired_count           = var.desired_count
  minimum_healthy_percent = var.minimum_healthy_percent
  maximum_percent         = var.maximum_percent
  container_port          = var.container_port
  service_name            = var.service_name
  container_name          = var.cluster_name
  cluster_id              = module.cluster.cluster_id
  private_subnet_ids      = var.private_subnet_ids
  task_definition_arn     = module.td.task_definition_arn
  service_discovery_arn   = aws_service_discovery_service.service_ds.arn
  enable_load_balancer    = var.enable_load_balancer
  target_group_arn        = module.tg.tg_arn
  tags                    = var.tags
}

#########################################################################
# AWS ECS Cluster Service's Target Group
#########################################################################
module "tg" {
  source                 = "surangajayalath/ecs-cluster/aws//modules/terraform-aws-alb-tg"
  version                = "1.0.0"
  target_group_name      = var.target_group_name
  target_group_port      = var.target_group_port
  routing_path           = var.routing_path
  health_check_path      = var.health_check_path
  alb_https_listener_arn = aws_lb_listener.http_listener.arn
  api_domain_name        = var.api_domain_name
  alb_listner_priority   = var.alb_listner_priority
  vpc_id                 = var.vpc_id
  tags                   = var.tags
}
```
