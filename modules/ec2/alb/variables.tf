variable "vpc" {
  description = "The ID of the VPC."
}

variable "alb_security_group" {
  description = "The ID of the security group for the ALB."
}

variable "public_subnet_ids" {
  description = "List of Public Subnet IDs"
  type        = list(string)
}

variable "alb_certificate_arn" {
  description = "ARN of the ACM certificate to associate with the ALB"
}