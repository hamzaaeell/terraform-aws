variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
  default     = "multi-az-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}# AutoScaling Group Variables Ends

# AutoScaling Group Variables
variable "asg_instance_type" {
  description = "EC2 instance type for AutoScaling Group"
  type        = string
  default     = "t3.micro"
}

variable "asg_min_size" {
  description = "Minimum number of instances in the AutoScaling Group"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Maximum number of instances in the AutoScaling Group"
  type        = number
  default     = 6
}

variable "asg_desired_capacity" {
  description = "Desired number of instances in the AutoScaling Group"
  type        = number
  default     = 2
}

variable "asg_key_name" {
  description = "SSH key name for instances"
  type        = string
  default     = ""
}

variable "asg_user_data" {
  description = "User data script to run on instances"
  type        = string
  default     = ""
}

variable "asg_spot_price" {
  description = "Maximum spot price (leave empty for on-demand)"
  type        = string
  default     = ""
}

# RDS Variables
variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "rds_engine_version" {
  description = "RDS engine version"
  type        = string
  default     = "17.2-R2"
}

variable "rds_allocated_storage" {
  description = "RDS allocated storage in GB"
  type        = number
  default     = 20
}

variable "rds_max_allocated_storage" {
  description = "RDS maximum allocated storage in GB"
  type        = number
  default     = 100
}

variable "rds_database_name" {
  description = "RDS database name"
  type        = string
  default     = "myapp"
}

variable "rds_username" {
  description = "RDS master username"
  type        = string
  default     = "postgres"
}

variable "rds_port" {
  description = "RDS port"
  type        = number
  default     = 5432
}

variable "rds_multi_az" {
  description = "Whether to create a standby instance in another AZ"
  type        = bool
  default     = true
}

variable "rds_create_read_replica" {
  description = "Whether to create a read replica"
  type        = bool
  default     = true
}

variable "rds_backup_retention_period" {
  description = "RDS backup retention period in days"
  type        = number
  default     = 7
}

variable "rds_allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access the RDS instance"
  type        = list(string)
  default     = []
}

variable "rds_storage_encrypted" {
  description = "Whether to encrypt the RDS storage"
  type        = bool
  default     = true
}

# ALB Variables
variable "alb_name" {
  description = "Name of the ALB"
  type        = string
  default     = ""
}

variable "alb_internal" {
  description = "Whether the ALB is internal"
  type        = bool
  default     = false
}

variable "alb_enable_deletion_protection" {
  description = "Whether to enable deletion protection for ALB"
  type        = bool
  default     = false
}

variable "alb_target_group_port" {
  description = "Port for the ALB target group"
  type        = number
  default     = 80
}

variable "alb_target_group_protocol" {
  description = "Protocol for the ALB target group"
  type        = string
  default     = "HTTP"
}

variable "alb_health_check_path" {
  description = "Health check path for ALB target group"
  type        = string
  default     = "/"
}

variable "alb_listener_port" {
  description = "Port for the ALB listener"
  type        = number
  default     = 80
}

variable "alb_listener_protocol" {
  description = "Protocol for the ALB listener"
  type        = string
  default     = "HTTP"
}

variable "alb_allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access the ALB"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "alb_enable_https" {
  description = "Whether to enable HTTPS listener"
  type        = bool
  default     = false
}

variable "alb_https_port" {
  description = "Port for HTTPS listener"
  type        = number
  default     = 443
}

variable "alb_certificate_arn" {
  description = "ARN of the SSL certificate"
  type        = string
  default     = ""
}