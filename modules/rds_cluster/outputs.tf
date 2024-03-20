output "rds_db_cluster_parameter_group_value" {
  description = "RDS DB Cluster Parameter Group Value"
  value       = aws_rds_cluster_parameter_group.contoh_db_cluster_parameter_group.name
}

# Define other outputs as needed

output "rds_cluster_id" {
  description = "The ID of the created RDS Aurora cluster"
  value       = aws_rds_cluster.contoh_db_cluster.id
}
# output "db_cluster_identifier" {
#   description = "The ID of the created RDS Aurora cluster"
#   value       = aws_rds_cluster.contoh_db_cluster.db_cluster_identifier
# }



# output "rds_cluster_endpoint" {
#   description = "The endpoint of the created RDS Aurora cluster"
#   value       = aws_rds_cluster.workload_cluster.endpoint
# }

# output "rds_cluster_port" {
#   description = "The port of the created RDS Aurora cluster"
#   value       = aws_rds_cluster.workload_cluster.port
# }
