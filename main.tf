terraform {
  backend "s3" {
    bucket = "terraform-state-lab-bellabeen"
    key    = "prod"
    region = "ap-southeast-1"
  }
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}


provider "aws" {
  region = "ap-southeast-1"
  # Create tags for the all resource add global tagging
    default_tags {
      tags = {
          "tunas:env" = "prod"
          "tunas:application:id" = "TEDS"
          "tunas:cost-center" = "TDM"
          "Project"= "TEDS on AWS"
          "created:by"             = "Terraform"
    }
  }
}

module "vpc" {
  source = "./modules/vpc"
  
  # Pass variables to the vpc module
  subnet_public_cidr      = var.subnet_public_cidr
  subnet_private_ec2_cidr = var.subnet_private_ec2_cidr
  subnet_private_db_cidr  = var.subnet_private_db_cidr
  availability_zone       = var.availability_zone
}

variable "subnet_public_cidr" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["20.0.1.0/24", "20.0.2.0/24", "20.0.3.0/24"]
}

variable "subnet_private_ec2_cidr" {
  type        = list(string)
  description = "Private Subnet EC2 CIDR values"
  default     = ["20.0.4.0/24", "20.0.5.0/24", "20.0.6.0/24"]
}

variable "subnet_private_db_cidr" {
  type        = list(string)
  description = "Private Subnet DB CIDR values"
  default     = ["20.0.7.0/24", "20.0.8.0/24", "20.0.9.0/24"]
}

variable "availability_zone" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
  all_description_egress = "open all egress"
  all_access_egress = ["0.0.0.0/0"]
  all_access_cidr_block_egress = ["0.0.0.0/0"]
  
  aws_all_cidr_blocks = ["0.0.0.0/0"]

  aws_local_cidr_ipv4_blocks = ["20.0.0.0/16"]
  aws_local_cidr_blocks = ["20.0.0.0/16"]
  aws_local_from_db_port = 5432
  aws_local_to_db_port = 5432
  aws_local_from_https_port = 443
  aws_local_to_https_port = 443
  
  ssl_vpn_cidr_blocks     = ["10.212.133.0/24"]
  ssl_vpn_from_db_port = 5432
  ssl_vpn_to_db_port = 5432
  
  sg_db_name = "SG-DB-CONTOH"
  sg_db_description = "Security group for DB CONTOH"
  sg_db_tags = {
    "Name"               = "SG-DB-CONTOH"
  }

  sg_alb_name = "SG-ALB-CONTOH"
  sg_alb_description = "Security group for ALB CONTOH"
  

}