# Define the AWS provider
provider "aws" {
  region = var.aws_region
}

# VPC Module
module "vpc" {
  source = "../Basic-autoscaling-architecture-EC2/Modules/VPC"

  project_name           = var.project_name
  environment            = terraform.workspace
  region                 = var.aws_region
  vpc_cidr               = var.vpc_cidr
  public_subnet_cidrs    = var.public_cidrs
  private_subnet_cidrs   = var.private_cidrs
}

# AutoScaling Group Module
module "autoscaling" {
  source = "../Basic-autoscaling-architecture-EC2/Modules/AutoScaling"

  project_name              = var.project_name
  environment               = terraform.workspace
  vpc_id                    = module.vpc.vpc_id
  private_subnet_ids        = module.vpc.private_subnet_ids
  target_group_arns         = [module.alb.target_group_arn]
  ami_id                    = var.ami_id
  instance_type             = var.instance_type
  key_name                  = var.key_name
  instance_profile_name     = var.instance_profile_name
  user_data                 = var.user_data
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  spot_price                = var.spot_price
}

# RDS Module
module "rds" {
  source = "../Basic-autoscaling-architecture-EC2/Modules/RDS"

  project_name              = var.project_name
  environment               = terraform.workspace
  vpc_id                    = module.vpc.vpc_id
  private_subnet_ids        = module.vpc.private_subnet_ids
  allowed_cidr_blocks       = var.allowed_cidr_blocks

  engine                    = var.engine
  engine_version            = var.engine_version
  instance_class            = var.instance_class
  allocated_storage         = var.allocated_storage
  max_allocated_storage      = var.max_allocated_storage
  storage_type              = var.storage_type
  storage_encrypted         = var.storage_encrypted
  database_name             = var.database_name
  username                  = var.username
  port                      = var.port
  backup_retention_period   = var.backup_retention_period
  backup_window             = var.backup_window
  maintenance_window        = var.maintenance_window
  multi_az                  = var.multi_az
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier
  deletion_protection       = var.deletion_protection
  create_read_replica       = var.create_read_replica
}

# ALB Module
module "alb" {
  source = "../Basic-autoscaling-architecture-EC2/Modules/ALB"

  project_name                    = var.project_name
  environment                     = terraform.workspace
  vpc_id                          = module.vpc.vpc_id
  public_subnet_ids               = module.vpc.public_subnet_ids
  allowed_cidr_blocks             = var.alb_security_group_cidrs
  target_group_port               = var.target_group_port
  target_group_protocol           = var.target_group_protocol
  health_check_path               = var.health_check_path
  health_check_interval           = var.health_check_interval
  health_check_timeout            = var.health_check_timeout
  health_check_healthy_threshold  = var.health_check_healthy_threshold
  health_check_unhealthy_threshold = var.health_check_unhealthy_threshold
  health_check_matcher             = var.health_check_matcher
  listener_port                   = var.listener_port
  listener_protocol               = var.listener_protocol
  listener_default_action_type    = var.listener_action_type
}