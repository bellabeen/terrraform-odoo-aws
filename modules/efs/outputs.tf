output "efs_resource_data" {
  value = aws_efs_file_system.efs_data.id
}

output "efs_resource_data_arn" {
  value = aws_efs_file_system.efs_data.arn
}

output "efs_resource_code" {
  value = aws_efs_file_system.efs_code.id
}

output "efs_resource_code_arn" {
  value = aws_efs_file_system.efs_code.arn
}

output "efs_resource_session_arn" {
  value = aws_efs_file_system.efs_session.arn
}

output "efs_resource_session" {
  value = aws_efs_file_system.efs_session.id
}
