# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.vpc.private_subnet_ids
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.vpc.internet_gateway_id
}

output "nat_gateway_ids" {
  description = "IDs of the NAT Gateways"
  value       = module.vpc.nat_gateway_ids
}

# AutoScaling Group Outputs
output "autoscaling_group_id" {
  description = "ID of the AutoScaling Group"
  value       = module.autoscaling.autoscaling_group_id
}

output "autoscaling_group_name" {
  description = "Name of the AutoScaling Group"
  value       = module.autoscaling.autoscaling_group_name
}

output "launch_template_id" {
  description = "ID of the Launch Template"
  value       = module.autoscaling.launch_template_id
}

# RDS Outputs
output "rds_instance_endpoint" {
  description = "RDS instance endpoint"
  value       = module.rds.database_instance_endpoint
}

output "rds_instance_id" {
  description = "RDS instance ID"
  value       = module.rds.database_instance_id
}

output "rds_instance_status" {
  description = "RDS instance status"
  value       = module.rds.database_instance_status
}

output "rds_instance_username" {
  description = "RDS instance username"
  value       = module.rds.database_instance_username
}

output "rds_instance_password" {
  description = "RDS instance password"
  value       = module.rds.database_instance_password
  sensitive   = true
}

output "read_replica_instance_endpoint" {
  description = "Read replica instance endpoint"
  value       = module.rds.read_replica_instance_endpoint
}

output "read_replica_instance_id" {
  description = "Read replica instance ID"
  value       = module.rds.read_replica_instance_id
}

output "read_replica_instance_status" {
  description = "Read replica instance status"
  value       = module.rds.read_replica_instance_status
}

# ALB Outputs
output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = module.alb.alb_dns_name
}

output "alb_id" {
  description = "ID of the ALB"
  value       = module.alb.alb_id
}

output "alb_arn" {
  description = "ARN of the ALB"
  value       = module.alb.alb_arn
}

output "target_group_arn" {
  description = "ARN of the target group"
  value       = module.alb.target_group_arn
}

output "listener_arn" {
  description = "ARN of the listener"
  value       = module.alb.http_listener_arn
}