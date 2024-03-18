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