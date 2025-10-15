variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the AutoScaling Group will be created"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the AutoScaling Group"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for the instances"
  type        = string
  default     = ""  # Will be set to latest Ubuntu 22.04 if empty
}

variable "min_size" {
  description = "Minimum number of instances in the AutoScaling Group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of instances in the AutoScaling Group"
  type        = number
  default     = 6
}

variable "desired_capacity" {
  description = "Desired number of instances in the AutoScaling Group"
  type        = number
  default     = 2
}

variable "health_check_type" {
  description = "Type of health check"
  type        = string
  default     = "EC2"
}

variable "health_check_grace_period" {
  description = "Grace period for health checks"
  type        = number
  default     = 300
}

variable "target_group_arns" {
  description = "List of target group ARNs for the AutoScaling Group"
  type        = list(string)
  default     = []
}

variable "instance_profile_name" {
  description = "IAM instance profile name for the instances"
  type        = string
  default     = ""
}

variable "user_data" {
  description = "User data script to run on instances"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "SSH key name for instances"
  type        = string
  default     = ""
}

variable "spot_price" {
  description = "Maximum spot price (leave empty for on-demand)"
  type        = string
  default     = ""
}

variable "spot_instance_types" {
  description = "List of instance types for spot instances"
  type        = list(string)
  default     = ["t3.micro", "t3a.micro"]
}