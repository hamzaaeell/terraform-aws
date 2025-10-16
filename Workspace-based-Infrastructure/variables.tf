# AWS Region
variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

# Project Name
variable "project_name" {
  description = "Project name for tagging"
  type        = string
  default     = "multi-az-vpc"
}

# VPC Configuration
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.20.0/24"]
}

# AutoScaling Group Configuration
variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
  default     = ""
}

variable "instance_profile_name" {
  description = "IAM instance profile name"
  type        = string
  default     = ""
}

variable "user_data" {
  description = "User data script for EC2 instances"
  type        = string
  default     = ""
}

variable "desired_capacity" {
  description = "Desired capacity for AutoScaling Group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum size for AutoScaling Group"
  type        = number
  default     = 6
}

variable "min_size" {
  description = "Minimum size for AutoScaling Group"
  type        = number
  default     = 2
}

variable "health_check_type" {
  description = "Health check type for AutoScaling Group"
  type        = string
  default     = "EC2"
}

variable "health_check_grace_period" {
  description = "Health check grace period for AutoScaling Group"
  type        = number
  default     = 300
}

variable "spot_price" {
  description = "Spot price for instances (leave empty to use on-demand)"
  type        = string
  default     = ""
}

# RDS Configuration
variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access RDS"
  type        = list(string)
  default     = []
}

variable "engine" {
  description = "Database engine"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
  default     = "17.2"
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Initial allocated storage for RDS"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Maximum allocated storage for RDS"
  type        = number
  default     = 100
}

variable "storage_type" {
  description = "Storage type for RDS"
  type        = string
  default     = "gp3"
}

variable "storage_encrypted" {
  description = "Whether to encrypt RDS storage"
  type        = bool
  default     = true
}

variable "database_name" {
  description = "Name of the database to create"
  type        = string
  default     = "myapp"
}

variable "username" {
  description = "Master username for RDS"
  type        = string
  default     = "postgres"
}

variable "port" {
  description = "Port for RDS"
  type        = number
  default     = 5432
}

variable "backup_retention_period" {
  description = "Backup retention period for RDS"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Preferred backup window for RDS"
  type        = string
  default     = "03:00-04:00"
}

variable "maintenance_window" {
  description = "Preferred maintenance window for RDS"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "multi_az" {
  description = "Whether to create a Multi-AZ RDS instance"
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Whether to skip final snapshot when destroying RDS"
  type        = bool
  default     = false
}

variable "final_snapshot_identifier" {
  description = "Identifier for final snapshot"
  type        = string
  default     = ""
}

variable "deletion_protection" {
  description = "Whether to enable deletion protection for RDS"
  type        = bool
  default     = false
}

variable "create_read_replica" {
  description = "Whether to create a read replica"
  type        = bool
  default     = true
}

# ALB Configuration
variable "alb_security_group_cidrs" {
  description = "CIDR blocks allowed to access ALB"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "target_group_port" {
  description = "Port for the target group"
  type        = number
  default     = 80
}

variable "target_group_protocol" {
  description = "Protocol for the target group"
  type        = string
  default     = "HTTP"
}

variable "target_group_target_type" {
  description = "Target type for the target group"
  type        = string
  default     = "instance"
}

variable "health_check_path" {
  description = "Health check path for the target group"
  type        = string
  default     = "/"
}

variable "health_check_interval" {
  description = "Health check interval for the target group"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Health check timeout for the target group"
  type        = number
  default     = 5
}

variable "health_check_healthy_threshold" {
  description = "Healthy threshold for health checks"
  type        = number
  default     = 3
}

variable "health_check_unhealthy_threshold" {
  description = "Unhealthy threshold for health checks"
  type        = number
  default     = 3
}

variable "health_check_matcher" {
  description = "HTTP status codes to consider healthy"
  type        = string
  default     = "200"
}

variable "listener_port" {
  description = "Port for the ALB listener"
  type        = number
  default     = 80
}

variable "listener_protocol" {
  description = "Protocol for the ALB listener"
  type        = string
  default     = "HTTP"
}

variable "listener_action_type" {
  description = "Action type for the ALB listener"
  type        = string
  default     = "forward"
}