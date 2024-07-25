################ AWS ECS Cluster #################
module "ecs-cluster" {
  source            = "./modules/terraform-aws-ecs-cluster"
  cluster_name      = var.cluster_name
  cw_log_group_name = "nginx/ecs/cluster"
  kms_key_id        = aws_kms_key.master_kms_key.arn
  tags              = var.tags
}

################ AWS ECS Cluster Service Task Definition #################
module "nginx_service_td" {
  source                          = "./modules/terraform-aws-ecs-task-definition"
  family_name                     = "nginx-service-td"
  task_execution_role_arn         = module.nginx_service_iam.ecs_task_execution_role_arn
  task_role_arn                   = module.nginx_service_iam.ecs_task_role_arn
  task_cpu                        = 256
  task_memory                     = 512
  tags                            = { environment = "beta" }
  container_definitions_file_path = file("ecs-task-definition/nginx-service-td.json")
}

################ AWS ECS Cluster Service #################
module "nginx_service" {
  source                      = "./modules/terraform-aws-ecs-service"
  desired_count               = 1
  minimum_healthy_percent     = 0
  maximum_percent             = 100
  container_port              = 8080
  service_name                = "nginx_service"
  container_name              = "nginx_service_container"
  cluster_id                  = module.ecs-cluster.cluster_id
  private_subnet_ids          = var.private_subnet_ids
  task_definition_arn         = module.nginx_service_td.task_definition_arn
  container_security_group_id = [aws_security_group.ecs_container_sg.id]
  service_discovery_arn       = aws_service_discovery_service.nginx_service_ds.arn
  enable_load_balancer        = true
  target_group_arn            = module.nginx_service_tg.tg_arn
  tags                        = { environment = "beta" }
}

################ AWS ECS Cluster Service TG #################
module "nginx_service_tg" {
  source                 = "./modules/terraform-aws-alb-tg"
  target_group_name      = "ecs-nginx-service-tg"
  target_group_port      = 3000
  routing_path           = "/api/nginxservice"
  health_check_path      = "/api/nginxservice/healthcheck"
  alb_https_listener_arn = aws_lb_listener.https_listener.arn
  alb_listner_priority   = 100
  domain_name            = var.api_domain_name
  vpc_id                 = var.vpc_id
  tags                   = { environment = "beta" }
}

################ AWS ECS Cluster Service IAM #################
module "nginx_service_iam" {
  source                       = "./modules/terraform-aws-iam"
  account_id                   = var.account_id
  region                       = var.region
  ecs_task_execution_role_name = "nginx-task-execution-role"
  ecs_task_role_name           = "nginx-task-role"
  kms_key_id                   = aws_kms_key.master_kms_key.key_id
  secret_manager_path          = "nginx/service/beta-rXvtzO"
  enable_s3_access_policy      = false
}

################ AWS ECS Cluster Service Scheduler #################
module "nginx_service_scheduler" {
  source                       = "./modules/terraform-aws-eventbridge-scheduler"
  scheduler_name               = "nginx-service"
  turn_on_schedule_expression  = "cron(0 8 ? * MON,TUE,WED,THU,FRI *)"
  turn_off_schedule_expression = "cron(0 22 ? * MON,TUE,WED,THU,FRI *)"
  ecs_cluster_name             = module.ecs-cluster.cluster_name
  ecs_service_name             = module.nginx_service.service_name
}