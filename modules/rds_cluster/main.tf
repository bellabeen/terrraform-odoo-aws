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
resource "aws_db_subnet_group" "contoh-db-subnet-group" {
  name        = "contoh-db-subnet-group"
  description = "Subnet Group Contoh Aurora DB"
  subnet_ids  = var.subnet_db_ids
  tags = {
    "Name" = "Contoh DB Subnet Group"
  }
}

# Create Cluser Parameter Group
resource "aws_rds_cluster_parameter_group" "contoh-cluster-parameter-group" {
  name        = "contoh-cluster-parameter-group"
  family      = "aurora-postgresql12"
  description = "Aurora Cluster Parameter Group Contoh"

  parameter {
    name  = "timezone"
    value = "Asia/Jakarta"
  }
  tags = {
    "Name" = "Contoh Cluster Parameter Group"
  }
}

# Create DB Parameter Group
resource "aws_db_parameter_group" "contoh-db-parameter-group" {
  name        = "contoh-db-parameter-group"
  family      = "aurora-postgresql12"
  description = "Aurora DB Parameter Group Contoh"

  parameter {
    name  = "shared_preload_libraries"
    value = "pg_stat_statements"
  }

  parameter {
    name  = "pg_stat_statements.track"
    value = "ALL"
  }

  tags = {
    "Name" = "Contoh DB Parameter Group"
  }
  
}

# # Create random password RDS
# resource "random_password" "db_master_password" {
#   length           = 16  # You can adjust the length of the password as needed
#   special          = true
#   override_special = "!@_#"
# }

# Create RDS Cluster
resource "aws_rds_cluster" "contoh-cluster" {
  cluster_identifier            = "contoh-cluster"
  db_subnet_group_name          = aws_db_subnet_group.contoh-db-subnet-group.name
  engine                        = "aurora-postgresql"
  engine_version                = "12.13"
  master_username               = var.db_master_username
  # master_password               = random_password.db_master_password.result
  master_password               = var.db_master_password
  port                          = 5432
  backup_retention_period       = 7
  storage_encrypted             = true
  vpc_security_group_ids        = [var.db_security_group_id]
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.contoh-cluster-parameter-group.name
  skip_final_snapshot      = true # to your aws_provider
  # final_snapshot_identifier = "my-final-snapshot"  # Specify the final snapshot identifier

  tags = {
    "Name" = "Contoh Cluster RDS"
    "map-migrated"      = "d-server-01fqo90npvo03y"
    "map-migrated-app"  = "db.asp"
  }
}

# Create DB Master
resource "aws_rds_cluster_instance" "contoh-db" {
  identifier                = "contoh-db"
  cluster_identifier        = aws_rds_cluster.contoh-cluster.id
  engine                     = "aurora-postgresql"   # Add this line
  instance_class            = "db.t3.large"
  availability_zone         = "ap-southeast-1a"
  publicly_accessible       = false
  db_parameter_group_name   = aws_db_parameter_group.contoh-db-parameter-group.name
  monitoring_interval       = 60
  monitoring_role_arn       = aws_iam_role.rds_monitoring_role.arn
  performance_insights_enabled  = true  # Enable Performance Insights

  tags = {
    "Name" = "Contoh DB Master"
  }
}

# TODO: uncomment if use replicate instance
# # Create DB Replicate
# resource "aws_rds_cluster_instance" "contoh-db-replica" {
#   identifier                = "contoh-db-replica"
#   cluster_identifier        = aws_rds_cluster.contoh-cluster.id
#   instance_class            = "db.t3.large"
#   availability_zone         = "ap-southeast-1a"  // Or choose your preferred availability zone
#   publicly_accessible       = false
#   engine                    = "aurora-postgresql"
#   db_parameter_group_name   = aws_db_parameter_group.contoh-db-parameter-group.name
#   monitoring_interval       = 60
#   monitoring_role_arn       = aws_iam_role.rds_monitoring_role.arn
#   performance_insights_enabled  = true  # Enable Performance Insights

#   tags = {
#     "Name" = "Contoh DB Replicate"
#   }
# }