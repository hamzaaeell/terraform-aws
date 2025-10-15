# Define the AWS provider
provider "aws" {
  region = var.aws_region
}

# Create VPC using the VPC module
module "vpc" {
  source = "../../Modules/VPC"

  region                = var.aws_region
  environment           = var.environment
  project_name          = var.project_name
  vpc_cidr              = var.vpc_cidr
  availability_zones    = var.availability_zones
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
}
#VPC END




#Autoscaling group start
# Create AutoScaling Group using the AutoScaling module
module "autoscaling" {
  source = "../../Modules/AutoScaling"

  environment        = var.environment
  project_name       = var.project_name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  instance_type     = var.asg_instance_type
  min_size          = var.asg_min_size
  max_size          = var.asg_max_size
  desired_capacity  = var.asg_desired_capacity
  key_name          = var.asg_key_name
  user_data         = var.asg_user_data
  spot_price        = var.asg_spot_price
  target_group_arns = [module.alb.target_group_arn]
}
#Autoscaling group Ends


#RDS Starts
# Create RDS instance using the RDS module
module "rds" {
  source = "../../Modules/RDS"

  environment               = var.environment
  project_name              = var.project_name
  vpc_id                    = module.vpc.vpc_id
  private_subnet_ids        = module.vpc.private_subnet_ids

  instance_class            = var.rds_instance_class
  engine_version            = var.rds_engine_version
  allocated_storage         = var.rds_allocated_storage
  max_allocated_storage     = var.rds_max_allocated_storage
  database_name             = var.rds_database_name
  username                  = var.rds_username
  port                      = var.rds_port
  multi_az                  = var.rds_multi_az
  create_read_replica       = var.rds_create_read_replica
  backup_retention_period   = var.rds_backup_retention_period
  allowed_cidr_blocks       = var.rds_allowed_cidr_blocks
  storage_encrypted         = var.rds_storage_encrypted
}

# Create ALB using the ALB module
module "alb" {
  source = "../../Modules/ALB"

  environment              = var.environment
  project_name             = var.project_name
  vpc_id                   = module.vpc.vpc_id
  public_subnet_ids        = module.vpc.public_subnet_ids

  alb_name                 = var.alb_name
  internal                 = var.alb_internal
  enable_deletion_protection = var.alb_enable_deletion_protection
  target_group_port        = var.alb_target_group_port
  target_group_protocol    = var.alb_target_group_protocol
  health_check_path        = var.alb_health_check_path
  listener_port            = var.alb_listener_port
  listener_protocol        = var.alb_listener_protocol
  allowed_cidr_blocks      = var.alb_allowed_cidr_blocks
  enable_https             = var.alb_enable_https
  https_port               = var.alb_https_port
  certificate_arn          = var.alb_certificate_arn
}

#RDS Ends