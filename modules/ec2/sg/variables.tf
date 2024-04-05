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

variable "ssl_vpn_ho_cidr_blocks" {
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


variable "all_access_egress" {
  description = "The end port for AWS local access"
}

variable "all_access_cidr_block_egress" {
  description = "CIDR blocks for AWS local access"
  type        = list(string)
}
variable "aws_local_cidr_blocks" {
  description = "CIDR blocks for AWS local access"
  type        = list(string)
}

variable "aws_local_private_ec2_ids" {
  description = "CIDR blocks IDs for AWS Private Subnet EC2"
  type        = list(string)
}

variable "aws_local_description" {
  description = "The end port for AWS local access"
}

variable "aws_local_private_ec2_description" {
  description = "From AWS local Private EC2 IDs"
}

variable "ssl_vpn_ho_description" {
  description = "The end port for AWS local access"
}

variable "aws_local_to_https_description" {
  description = "The end port for AWS local access"
}

variable "aws_local_to_http_description" {
  description = "The end port for AWS local access"
}

variable "aws_local_to_http_port" {
  description = "The end port for AWS local access"
}

variable "aws_local_from_http_port" {
  description = "The end port for AWS local access"
}

variable "sg_app_tags" {
  description = "A map of tags to assign to the security group."
  type        = map(string)
}

variable "sg_app_name" {
  description = "The name of the security group"
}

variable "sg_app_description" {
  description = "The description of the security group"
}

variable "aws_local_from_xmlrpc_port" {
  description = "The end port for AWS local access"
}

variable "aws_local_to_xmlrpc_port" {
  description = "The end port for AWS local access"
}

variable "aws_local_protocol_tcp" {
  description = "The end port for AWS local access"
}

variable "aws_local_protocol_icmp" {
  description = "The end port for AWS local access"
}

variable "aws_local_protocol_ssh" {
  description = "The end port for AWS local access"
}

variable "aws_local_from_port_ssh" {
  description = "The end port for AWS local access"
}

variable "aws_local_to_port_ssh" {
  description = "The end port for AWS local access"
}

variable "aws_local_from_port_icmp" {
  description = "The end port for AWS local access"
}

variable "aws_local_to_port_icmp" {
  description = "The end port for AWS local access"
}

variable "sg_efs_name" {
  description = "Description for the EFS security group"
}

variable "sg_efs_description" {
  description = "The description of the security group"
}

variable "efs_ingress_cidr_blocks" {
  description = "CIDR blocks for EFS ingress rules."
  type        = list(string)
}

variable "sg_efs_tags" {
  description = "A map of tags to assign to the security group."
  type        = map(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs to allow ingress traffic from"
  type        = list(string)
  # default     = ["subnet-0611f3c336b76ed4b", "subnet-08bb03e7cd1b9c53e", "subnet-022093418e315cbfd"]
}

variable "subnet_tags" {
  description = "Map of subnet tags to allow ingress traffic from"
  type        = map(string)
  default     = {
    "Private Subnet App A" = "Private Subnet App A",
    "Private Subnet App B" = "Private Subnet App B",
    "Private Subnet App C" = "Private Subnet App C",
  }
}