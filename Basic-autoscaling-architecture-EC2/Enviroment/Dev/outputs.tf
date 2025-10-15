# VPC Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

# Subnet Outputs
output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnet_ids
}

output "public_subnet_cidrs" {
  description = "List of CIDR blocks of public subnets"
  value       = module.vpc.public_subnet_cidrs
}

output "private_subnet_cidrs" {
  description = "List of CIDR blocks of private subnets"
  value       = module.vpc.private_subnet_cidrs
}

# Gateway Outputs
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = module.vpc.internet_gateway_id
}

output "nat_gateway_ids" {
  description = "List of NAT Gateway IDs"
  value       = module.vpc.nat_gateway_ids
}

output "nat_gateway_public_ips" {
  description = "List of NAT Gateway public IP addresses"
  value       = module.vpc.nat_gateway_public_ips
}

# Route Table Outputs
output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = module.vpc.public_route_table_id
}

output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = module.vpc.private_route_table_ids
}

# AZ Outputs
output "availability_zones" {
  description = "List of availability zones"
  value       = module.vpc.availability_zones
}

# AutoScaling Group Outputs
output "autoscaling_group_id" {
  description = "The AutoScaling Group ID"
  value       = module.autoscaling.autoscaling_group_id
}

output "autoscaling_group_name" {
  description = "The AutoScaling Group name"
  value       = module.autoscaling.autoscaling_group_name
}

output "launch_template_id" {
  description = "The Launch Template ID"
  value       = module.autoscaling.launch_template_id
}

output "launch_template_name" {
  description = "The Launch Template name"
  value       = module.autoscaling.launch_template_name
}

output "security_group_id" {
  description = "The Security Group ID for instances"
  value       = module.autoscaling.security_group_id
}

output "iam_role_name" {
  description = "The IAM role name for instances"
  value       = module.autoscaling.iam_role_name
}

output "scale_out_policy_arn" {
  description = "The ARN of the scale out policy"
  value       = module.autoscaling.scale_out_policy_arn
}

output "scale_in_policy_arn" {
  description = "The ARN of the scale in policy"
  value       = module.autoscaling.scale_in_policy_arn
}

output "cpu_high_alarm_arn" {
  description = "The ARN of the CPU high alarm"
  value       = module.autoscaling.cpu_high_alarm_arn
}

output "cpu_low_alarm_arn" {
  description = "The ARN of the CPU low alarm"
  value       = module.autoscaling.cpu_low_alarm_arn
}

output "ubuntu_ami_id" {
  description = "The Ubuntu 22.04 AMI ID"
  value       = module.autoscaling.ubuntu_ami_id
}

# RDS Outputs
output "database_instance_id" {
  description = "The RDS instance ID"
  value       = module.rds.database_instance_id
}

output "database_instance_endpoint" {
  description = "The RDS instance endpoint"
  value       = module.rds.database_instance_endpoint
}

output "database_instance_port" {
  description = "The RDS instance port"
  value       = module.rds.database_instance_port
}

output "database_instance_status" {
  description = "The RDS instance status"
  value       = module.rds.database_instance_status
}

output "database_instance_username" {
  description = "The RDS instance master username"
  value       = module.rds.database_instance_username
}

output "database_instance_password" {
  description = "The auto-generated database password"
  value       = module.rds.database_instance_password
  sensitive   = true
}

output "database_instance_name" {
  description = "The database name"
  value       = module.rds.database_instance_name
}

output "database_instance_engine" {
  description = "The database engine"
  value       = module.rds.database_instance_engine
}

output "database_instance_engine_version" {
  description = "The database engine version"
  value       = module.rds.database_instance_engine_version
}

output "database_instance_class" {
  description = "The database instance class"
  value       = module.rds.database_instance_class
}

output "database_instance_multi_az" {
  description = "Whether the database is multi-AZ"
  value       = module.rds.database_instance_multi_az
}

output "database_subnet_group_id" {
  description = "The database subnet group ID"
  value       = module.rds.database_subnet_group_id
}

output "database_security_group_id" {
  description = "The database security group ID"
  value       = module.rds.database_security_group_id
}

output "database_secret_arn" {
  description = "The ARN of the database secret in AWS Secrets Manager"
  value       = module.rds.database_secret_arn
}

output "read_replica_instance_endpoint" {
  description = "The read replica instance endpoint"
  value       = module.rds.read_replica_instance_endpoint
}

output "read_replica_instance_status" {
  description = "The read replica instance status"
  value       = module.rds.read_replica_instance_status
}

# ALB Outputs
output "alb_arn" {
  description = "The ARN of the ALB"
  value       = module.alb.alb_arn
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = module.alb.alb_dns_name
}

output "alb_hosted_zone_id" {
  description = "The hosted zone ID of the ALB"
  value       = module.alb.alb_hosted_zone_id
}

output "alb_id" {
  description = "The ID of the ALB"
  value       = module.alb.alb_id
}

output "alb_name" {
  description = "The name of the ALB"
  value       = module.alb.alb_name
}

output "alb_security_group_id" {
  description = "The security group ID of the ALB"
  value       = module.alb.alb_security_group_id
}

output "target_group_arn" {
  description = "The ARN of the target group"
  value       = module.alb.target_group_arn
}

output "target_group_name" {
  description = "The name of the target group"
  value       = module.alb.target_group_name
}

output "http_listener_arn" {
  description = "The ARN of the HTTP listener"
  value       = module.alb.http_listener_arn
}

output "https_listener_arn" {
  description = "The ARN of the HTTPS listener"
  value       = module.alb.https_listener_arn
}