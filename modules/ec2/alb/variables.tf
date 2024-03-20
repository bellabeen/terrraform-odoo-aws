variable "vpc" {
  description = "The ID of the VPC."
}

# variable "public_subnet_a" {
#   description = "The ID of the public subnet A."
# }

# variable "public_subnet_b" {
#   description = "The ID of the public subnet B."
# }

variable "alb_security_group" {
  description = "The ID of the security group for the ALB."
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

# variable "alb_certificate_arn" {
#   description = "ARN of the ACM certificate to associate with the ALB"
# }