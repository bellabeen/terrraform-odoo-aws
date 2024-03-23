variable "vpc_id" {
  description = "VPC ID"
}
variable "subnet_db_ids" {
  description = "Subnet DB Private IDs"
  type = list(string)
}

variable "db_security_group_id" {
  description = "DB Security Group ID"
}
variable "db_master_username" {
  description = "Username master RDS"
}
variable "db_master_password" {
  description = "Password master RDS"
}