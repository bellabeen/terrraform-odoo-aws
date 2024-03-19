variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "sg_name" {
  description = "The name of the security group"
  type        = string
}

variable "sg_description" {
  description = "The description of the security group"
  type        = string
}

variable "aws_local_cidr_blocks" {
  description = "CIDR blocks for AWS Local ingress"
  type        = list(string)
}

variable "aws_local_from_port" {
  description = "From port for AWS Local ingress"
  type        = number
}

variable "aws_local_to_port" {
  description = "To port for AWS Local ingress"
  type        = number
}

variable "ssl_vpn_cidr_blocks" {
  description = "CIDR blocks for SSL VPN ingress"
  type        = list(string)
}

variable "ssl_vpn_from_port" {
  description = "From port for SSL VPN ingress"
  type        = number
}

variable "ssl_vpn_to_port" {
  description = "To port for SSL VPN ingress"
  type        = number
}

variable "sg_tags" {
  description = "Tags for the security group"
  type        = map(string)
}
