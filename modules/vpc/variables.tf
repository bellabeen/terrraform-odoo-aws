variable "subnet_public_cidr" {
  type        = list(string)
  description = "Public Subnet CIDR values"
}

variable "subnet_private_ec2_cidr" {
  type        = list(string)
  description = "Private Subnet EC2 CIDR values"
}

variable "subnet_private_db_cidr" {
  type        = list(string)
  description = "Private Subnet DB CIDR values"
}

variable "availability_zone" {
  type        = list(string)
  description = "Availability Zones"
}