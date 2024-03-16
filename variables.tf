# variable "instance_name" {
#   description = "Value of the Name tag for the EC2 instance"
#   type        = string
#   default     = "ExampleServerVariable"
# }

# variable "subnet_public_cidr" {
#   type        = list(string)
#   description = "Public Subnet CIDR values"
#   default     = ["20.0.1.0/24", "20.0.2.0/24", "20.0.3.0/24"]
# }

# variable "subnet_private_ec2_cidr" {
#   type        = list(string)
#   description = "Private Subnet EC2 CIDR values"
#   default     = ["20.0.4.0/24", "20.0.5.0/24", "20.0.6.0/24"]
# }

# variable "subnet_private_db_cidr" {
#   type        = list(string)
#   description = "Private Subnet DB CIDR values"
#   default     = ["20.0.7.0/24", "20.0.8.0/24", "20.0.9.0/24"]
# }

# variable "availability_zone" {
#  type        = list(string)
#  description = "Availability Zones"
#  default     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
# }