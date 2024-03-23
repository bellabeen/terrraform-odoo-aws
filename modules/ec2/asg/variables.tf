variable "vpc_id" {
  description = "The VPC ID"
}

variable "volume_size" {
  description = "Volume Size of the Auto Scaling"
  type        = string
}

variable "app_instance_type" {
  description = "Instance type of the Auto Scaling App"
  type        = string
}

variable "sg_app_ids" {
  description = "Security Group ID of the Auto Scaling App"
}

variable "subnet_db_ids" {
  description = "Subnet Private DB CIDR ID"
  type = list(string)
}

variable "subnet_app_ids" {
  description = "Subnet Private EC2 CIDR ID"
  type = list(string)
}

# variable "availability_zone" {
#   type        = list(string)
#   description = "Availability Zones"
# }

# variable "availability_zone_ids" {
#   type        = list(string)
#   description = "Availability Zones ID"
# }

variable "ami_app_id" {
  description = "AMI Instance ID of the Auto Scaling App"
  type        = string
}

variable "target_group_alb_arn" {

}