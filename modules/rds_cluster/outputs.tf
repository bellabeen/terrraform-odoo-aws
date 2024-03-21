# Define other outputs as needed
output "rds_db_cluster_parameter_group_value" {
  description = "The Name of the RDS DB Cluster Parameter Group Value"
  value       = aws_rds_cluster_parameter_group.contoh-cluster-parameter-group.name
}

output "rds_cluster_id" {
  description = "The ID of the created RDS Aurora cluster"
  value       = aws_rds_cluster.contoh-cluster.id
}

output "rds_monitoring_role_arn" {
  description = "The ARN of the RDS Monitoring Role"
  value       = aws_iam_role.rds_monitoring_role.arn
}

# output "generated_db_master_password" {
#   value = random_password.db_master_password.result
# }