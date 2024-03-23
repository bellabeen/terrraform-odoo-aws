# Create IAM Role For RDS Monitoring
resource "aws_iam_role" "rds_monitoring_role" {
  name               = "rds-managed-monitoring-role"
  assume_role_policy = jsonencode({
    "Version"   : "2012-10-17",
    "Statement" : [
      {
        "Effect"    : "Allow",
        "Principal" : { "Service" : "monitoring.rds.amazonaws.com" },
        "Action"    : "sts:AssumeRole"
      }
    ]
  })
}

# Create IAM Policy
resource "aws_iam_policy_attachment" "rds_monitoring_attachment" {
  name       = "rds-monitoring-attachment"
  roles      = [aws_iam_role.rds_monitoring_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

# Create DB Subnet Group
resource "aws_db_subnet_group" "example-db-subnet-group" {
  name        = "example-db-subnet-group"
  description = "Subnet Group Example Aurora DB"
  subnet_ids  = var.subnet_db_ids
  tags = {
    "Name" = "Example DB Subnet Group"
  }
}

# Create Cluser Parameter Group
resource "aws_rds_cluster_parameter_group" "example-cluster-parameter-group" {
  name        = "example-cluster-parameter-group"
  family      = "aurora-postgresql12"
  description = "Aurora Cluster Parameter Group Example"

  parameter {
    name  = "timezone"
    value = "Asia/Jakarta"
  }
  tags = {
    "Name" = "Example Cluster Parameter Group"
  }
}

# Create DB Parameter Group
resource "aws_db_parameter_group" "example-db-parameter-group" {
  name        = "example-db-parameter-group"
  family      = "aurora-postgresql12"
  description = "Aurora DB Parameter Group Example"

  parameter {
    name  = "shared_preload_libraries"
    value = "pg_stat_statements"
  }

  parameter {
    name  = "pg_stat_statements.track"
    value = "ALL"
  }

  tags = {
    "Name" = "Example DB Parameter Group"
  }
  
}

# TODO: How to create random password RDS and feedback to prompt
# Create random password RDS
# resource "random_password" "db_master_password" {
#   length           = 16  # You can adjust the length of the password as needed
#   special          = true
#   override_special = "!@_#"
# }

# Create RDS Cluster
resource "aws_rds_cluster" "example-cluster" {
  cluster_identifier            = "example-cluster"
  db_subnet_group_name          = aws_db_subnet_group.example-db-subnet-group.name
  engine                        = "aurora-postgresql"
  engine_version                = "12.13"
  master_username               = var.db_master_username
  # TODO: uncomment this code use random password db
  # master_password               = random_password.db_master_password.result
  master_password               = var.db_master_password
  port                          = 5432
  backup_retention_period       = 7
  preferred_backup_window = "05:01-06:30" # Time in UTC
  storage_encrypted             = true
  vpc_security_group_ids        = [var.db_security_group_id]
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.example-cluster-parameter-group.name
  skip_final_snapshot      = true # to your aws_provider
  # final_snapshot_identifier = "my-final-snapshot"  # Specify the final snapshot identifier
  copy_tags_to_snapshot = true

  tags = {
    "Name" = "Example Cluster RDS"
    "map-migrated"      = "d-server-01fqo90npvo03y"
    "map-migrated-app"  = "db.asp"
  }
}

# Create DB Master
resource "aws_rds_cluster_instance" "example-db" {
  identifier                = "example-db"
  cluster_identifier        = aws_rds_cluster.example-cluster.id
  engine                     = "aurora-postgresql"   # Add this line
  instance_class            = "db.t3.medium"
  availability_zone         = "ap-southeast-1a"
  publicly_accessible       = false
  db_parameter_group_name   = aws_db_parameter_group.example-db-parameter-group.name
  monitoring_interval       = 60
  monitoring_role_arn       = aws_iam_role.rds_monitoring_role.arn
  performance_insights_enabled  = true  # Enable Performance Insights

  tags = {
    "Name" = "Example DB Master"
  }
}

# TODO: uncomment if use replicate instance
# # Create DB Replicate
# resource "aws_rds_cluster_instance" "example-db-replica" {
#   identifier                = "example-db-replica"
#   cluster_identifier        = aws_rds_cluster.example-cluster.id
#   instance_class            = "db.t3.medium"
#   availability_zone         = "ap-southeast-1a"  // Or choose your preferred availability zone
#   publicly_accessible       = false
#   engine                    = "aurora-postgresql"
#   db_parameter_group_name   = aws_db_parameter_group.example-db-parameter-group.name
#   monitoring_interval       = 60
#   monitoring_role_arn       = aws_iam_role.rds_monitoring_role.arn
#   performance_insights_enabled  = true  # Enable Performance Insights

#   tags = {
#     "Name" = "Example DB Replicate"
#   }
# }