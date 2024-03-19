variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created."
  type        = string
}

variable "sg_db_name" {
  description = "The name of the security group"
}

variable "sg_db_description" {
  description = "The description of the security group"
}

variable "aws_local_from_db_port" {
  description = "The start port for AWS local access"
}

variable "aws_local_to_db_port" {
  description = "The end port for AWS local access"
}

variable "ssl_vpn_cidr_blocks" {
  description = "CIDR blocks for SSL VPN access"
  type        = list(string)
}

variable "ssl_vpn_from_db_port" {
  description = "The start port for SSL VPN access"
}

variable "ssl_vpn_to_db_port" {
  description = "The end port for SSL VPN access"
}

variable "sg_db_tags" {
  description = "Additional tags for the security group"
  type        = map(string)
}

variable "sg_alb_tags" {
  description = "A map of tags to assign to the security group."
  type        = map(string)
  default     = {
    "Name"               = "SG-ALB-CONTOH"
    "created:by"         = "Terraform"
  }
}

variable "sg_alb_name" {
  description = "The name of the security group"
}

variable "sg_alb_description" {
  description = "The description of the security group"
}

variable "aws_all_cidr_blocks" {
  description = "CIDR blocks for AWS local access"
  type        = list(string)
}

variable "aws_local_to_https_port" {
  description = "The end port for AWS local access"
}

variable "aws_local_from_https_port" {
  description = "The end port for AWS local access"
}

variable "all_description_egress" {
  description = "The end port for AWS local access"
}

variable "aws_local_cidr_ipv4_blocks" {
  description = "CIDR blocks for AWS local access"
}

variable "aws_local_cidr_blocks" {
  description = "CIDR blocks for AWS local access"
  type        = list(string)
}

variable "all_access_egress" {
  description = "The end port for AWS local access"
}

variable "all_access_cidr_block_egress" {
  description = "CIDR blocks for AWS local access"
  type        = list(string)
}