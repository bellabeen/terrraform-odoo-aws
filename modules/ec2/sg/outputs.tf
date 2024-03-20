output "security_group_id" {
  description = "The ID of the created security group"
  value       = aws_security_group.db_security_group.id
}

output "alb_security_group_id" {
  description = "The ID of the created ALB security group."
  value       = aws_security_group.alb_security_group.id
}

output "efs_security_group_id" {
  description = "The ID of the created EFS security group."
  value       = aws_security_group.efs_security_group.id
}

output "app_security_group_id" {
  description = "The ID of the created App security group."
  value       = aws_security_group.app_security_group.id
}

output "db_security_group_id" {
  description = "The ID of the created DB security group."
  value       = aws_security_group.db_security_group.id
}