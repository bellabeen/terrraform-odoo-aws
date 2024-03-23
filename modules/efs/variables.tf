variable "vpc_id" {
  description = "The ID of the VPC."
}

variable "subnet_app_ids" {
  description = "Subnet Private EC2 CIDR ID"
  type = list(string)
}

variable "efs_security_group_id" {
  description = "EFS Security Group ID"
}


