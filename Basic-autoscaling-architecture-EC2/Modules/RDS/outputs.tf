output "database_instance_id" {
  description = "The RDS instance ID"
  value       = aws_db_instance.main.id
}

output "database_instance_arn" {
  description = "The RDS instance ARN"
  value       = aws_db_instance.main.arn
}

output "database_instance_endpoint" {
  description = "The RDS instance endpoint"
  value       = aws_db_instance.main.endpoint
}

output "database_instance_hosted_zone_id" {
  description = "The RDS instance hosted zone ID"
  value       = aws_db_instance.main.hosted_zone_id
}

output "database_instance_port" {
  description = "The RDS instance port"
  value       = aws_db_instance.main.port
}

output "database_instance_status" {
  description = "The RDS instance status"
  value       = aws_db_instance.main.status
}

output "database_instance_username" {
  description = "The RDS instance master username"
  value       = aws_db_instance.main.username
}

output "database_instance_password" {
  description = "The auto-generated database password"
  value       = random_password.password.result
  sensitive   = true
}

output "database_instance_name" {
  description = "The database name"
  value       = aws_db_instance.main.db_name
}

output "database_instance_engine" {
  description = "The database engine"
  value       = aws_db_instance.main.engine
}

output "database_instance_engine_version" {
  description = "The database engine version"
  value       = aws_db_instance.main.engine_version
}

output "database_instance_class" {
  description = "The database instance class"
  value       = aws_db_instance.main.instance_class
}

output "database_instance_allocated_storage" {
  description = "The database allocated storage"
  value       = aws_db_instance.main.allocated_storage
}

output "database_instance_storage_type" {
  description = "The database storage type"
  value       = aws_db_instance.main.storage_type
}

output "database_instance_storage_encrypted" {
  description = "Whether the database storage is encrypted"
  value       = aws_db_instance.main.storage_encrypted
}

output "database_instance_multi_az" {
  description = "Whether the database is multi-AZ"
  value       = aws_db_instance.main.multi_az
}

output "database_instance_backup_retention_period" {
  description = "The database backup retention period"
  value       = aws_db_instance.main.backup_retention_period
}

output "database_subnet_group_id" {
  description = "The database subnet group ID"
  value       = aws_db_subnet_group.main.id
}

output "database_subnet_group_arn" {
  description = "The database subnet group ARN"
  value       = aws_db_subnet_group.main.arn
}

output "database_security_group_id" {
  description = "The database security group ID"
  value       = aws_security_group.rds.id
}

output "database_security_group_arn" {
  description = "The database security group ARN"
  value       = aws_security_group.rds.arn
}

output "database_secret_arn" {
  description = "The ARN of the database secret in AWS Secrets Manager"
  value       = aws_secretsmanager_secret.database.arn
}

output "database_secret_name" {
  description = "The name of the database secret in AWS Secrets Manager"
  value       = aws_secretsmanager_secret.database.name
}

# Read replica outputs (only if created)
output "read_replica_instance_id" {
  description = "The read replica instance ID"
  value       = var.create_read_replica ? aws_db_instance.read_replica[0].id : null
}

output "read_replica_instance_arn" {
  description = "The read replica instance ARN"
  value       = var.create_read_replica ? aws_db_instance.read_replica[0].arn : null
}

output "read_replica_instance_endpoint" {
  description = "The read replica instance endpoint"
  value       = var.create_read_replica ? aws_db_instance.read_replica[0].endpoint : null
}

output "read_replica_instance_status" {
  description = "The read replica instance status"
  value       = var.create_read_replica ? aws_db_instance.read_replica[0].status : null
}