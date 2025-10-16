# Generate a random password for the database
resource "random_password" "password" {
  length           = 16
  special          = true
  min_numeric      = 1
  min_upper        = 1
  min_lower        = 1
  min_special      = 1
  override_special = "!#$%&"
}

# Store the password in AWS Secrets Manager for better security
resource "aws_secretsmanager_secret" "database" {
  name                    = "${var.project_name}-${var.environment}-database-credentials"
  description             = "Database credentials for ${var.project_name} ${var.environment}"
  recovery_window_in_days = 0

  tags = {
    Name        = "${var.project_name}-${var.environment}-database-secret"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_secretsmanager_secret_version" "database" {
  secret_id = aws_secretsmanager_secret.database.id
  secret_string = jsonencode({
    username = var.username
    password = random_password.password.result
    host     = aws_db_instance.main.address
    port     = var.port
    dbname   = var.database_name
  })
}

# Create DB subnet group
resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-${var.environment}-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name        = "${var.project_name}-${var.environment}-subnet-group"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Create security group for RDS
resource "aws_security_group" "rds" {
  name_prefix = "${var.project_name}-${var.environment}-rds-"
  vpc_id      = var.vpc_id

  # PostgreSQL port
  ingress {
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  # Allow access from the VPC CIDR if no specific CIDRs provided
  dynamic "ingress" {
    for_each = length(var.allowed_cidr_blocks) > 0 ? [] : [1]
    content {
      from_port   = var.port
      to_port     = var.port
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-rds-sg"
    Environment = var.environment
    Project     = var.project_name
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Create the main RDS instance
resource "aws_db_instance" "main" {
  identifier = "${var.project_name}-${var.environment}-db"

  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  storage_encrypted     = var.storage_encrypted

  db_name  = var.database_name
  username = var.username
  password = random_password.password.result

  port = var.port

  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  backup_retention_period = var.backup_retention_period
  backup_window          = var.backup_window
  maintenance_window     = var.maintenance_window

  multi_az = var.multi_az

  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier != "" ? var.final_snapshot_identifier : "${var.project_name}-${var.environment}-final-snapshot-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"

  deletion_protection = var.deletion_protection

  # Enable enhanced monitoring
  monitoring_interval = 60
  monitoring_role_arn = aws_iam_role.rds_enhanced_monitoring.arn

  tags = {
    Name        = "${var.project_name}-${var.environment}-db"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Wait for the main RDS instance to be available before creating the read replica
resource "time_sleep" "wait_for_main_db" {
  depends_on = [aws_db_instance.main]

  create_duration = "60s"
}

# Create read replica if enabled
resource "aws_db_instance" "read_replica" {
  count = var.create_read_replica ? 1 : 0

  identifier = "${var.project_name}-${var.environment}-db-read-replica"

  # Replicate from the main instance using ARN
  replicate_source_db = aws_db_instance.main.arn

  instance_class = var.instance_class

  port = var.port

  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name
  
  # Explicitly set storage_encrypted to match the main instance
  storage_encrypted = var.storage_encrypted

  # Read replicas don't need multi-AZ
  multi_az = false

  # Skip final snapshot for read replica
  skip_final_snapshot = true

  tags = {
    Name        = "${var.project_name}-${var.environment}-db-read-replica"
    Environment = var.environment
    Project     = var.project_name
    Type        = "ReadReplica"
  }

  # Ensure the read replica is created after the main instance is fully available
  depends_on = [aws_db_instance.main, time_sleep.wait_for_main_db]
}

# IAM role for enhanced monitoring
resource "aws_iam_role" "rds_enhanced_monitoring" {
  name = "${var.project_name}-${var.environment}-rds-enhanced-monitoring"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-${var.environment}-rds-enhanced-monitoring"
    Environment = var.environment
    Project     = var.project_name
  }
}

# IAM policy for enhanced monitoring
resource "aws_iam_role_policy_attachment" "rds_enhanced_monitoring" {
  role       = aws_iam_role.rds_enhanced_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
