output "security_group_id" {
  description = "The ID of the created security group"
  value       = aws_security_group.db_security_group.id
}

output "alb_security_group_id" {
  description = "The ID of the created ALB security group."
  value       = aws_security_group.alb_security_group.id
}
