provider "aws" {
  region = "ap-southeast-1"
  # Create tags for the all resource add global tagging
  default_tags {
    tags = {
      "company:env"            = "prod"
      "company:application:id" = "Example"
      "company:cost-center"    = "IT"
      "Project"              = "Example on AWS"
      "created:by"           = "Terraform"
    }
  }
}

# Use Module VPC
module "vpc" {
  source = "./modules/vpc"

  # Pass variables to the vpc module
  subnet_public_cidr      = var.subnet_public_cidr
  subnet_private_ec2_cidr = var.subnet_private_ec2_cidr
  subnet_private_db_cidr  = var.subnet_private_db_cidr
  availability_zone       = var.availability_zone
}

# Use Module Security Group
module "sg" {
  source = "./modules/ec2/sg"

  # Inherit another module
  vpc_id                  = module.vpc.vpc_id
  aws_local_cidr_blocks   = [module.vpc.vpc_cidr_block]
  efs_ingress_cidr_blocks = ["172.31.0.0/16"] # Example CIDR blocks for EFS ingress

  aws_all_cidr_blocks        = ["0.0.0.0/0"]
  aws_local_cidr_ipv4_blocks = ["20.0.0.0/16"]
  aws_local_description      = "AWS Local Segment"
  aws_local_protocol_tcp     = "tcp"
  aws_local_protocol_icmp    = "icmp"
  aws_local_protocol_ssh     = 22

  # AWS local to custom port
  aws_local_from_port_ssh    = "22"
  aws_local_to_port_ssh      = "22"
  aws_local_from_port_icmp   = "-1"
  aws_local_to_port_icmp     = "-1"
  aws_local_from_db_port     = 5432
  aws_local_to_db_port       = 5432
  aws_local_from_https_port  = 443
  aws_local_to_https_port    = 443
  aws_local_from_http_port   = 80
  aws_local_to_http_port     = 80
  aws_local_from_xmlrpc_port = 8069
  aws_local_to_xmlrpc_port   = 8069

  all_description_egress       = "open all egress"
  all_access_egress            = ["0.0.0.0/0"]
  all_access_cidr_block_egress = ["0.0.0.0/0"]

  # AWS local for description
  aws_local_to_https_description = "All access ALB from https"
  aws_local_to_http_description  = "All access ALB from http"

  # Custom config SSL VPN
  ssl_vpn_ho_cidr_blocks = ["10.212.133.0/24"]
  ssl_vpn_ho_description = "SSL VPN 200F HO"
  ssl_vpn_from_db_port   = 5432
  ssl_vpn_to_db_port     = 5432

  sg_db_name        = "SG-DB-EXAMPLE"
  sg_db_description = "Security group for DB EXAMPLE"
  sg_db_tags = {
    "Name" = "SG-DB-EXAMPLE"
  }

  sg_alb_name        = "SG-ALB-EXAMPLE"
  sg_alb_description = "Security group for ALB EXAMPLE"
  sg_alb_tags = {
    "Name" = "SG-ALB-EXAMPLE"
  }

  sg_app_name        = "SG-APP-EXAMPLE"
  sg_app_description = "Security group for APP EXAMPLE"
  sg_app_tags = {
    "Name" = "SG-APP-EXAMPLE"
  }

  sg_efs_name        = "SG-EFS-EXAMPLE"
  sg_efs_description = "Security group for EFS EXAMPLE"
  sg_efs_tags = {
    "Name" = "SG-EFS-EXAMPLE"
  }
}

# Use Module Certificate Manager
module "acm_certificate" {
  source = "./modules/acm_certificate"
  # You can provide necessary variables here
}

# Use Module Elastic Load Balancing
module "alb" {
  source = "./modules/ec2/alb"

  # Provide necessary arguments
  vpc                 = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  alb_security_group  = module.sg.alb_security_group_id
  alb_certificate_arn = module.acm_certificate.acm_certificate_arn
}

# Use Module WAF
module "waf" {
  source = "./modules/waf"

  # You can provide necessary variables here
  alb_arn = module.alb.alb_arn
}

# Use Module RDS Aurora
module "rds_cluster" {
  source = "./modules/rds_cluster"
  vpc_id = module.vpc.vpc_id
  db_security_group_id = module.sg.db_security_group_id
  subnet_db_ids = module.vpc.private_db_subnet_ids
  db_master_username = "postgres"
  db_master_password = "postgres"
}

# Use Module Route53
# TODO: if use route53 uncomment this code
# module "route53" {
#   source = "./modules/route53"
#   # You can provide necessary variables here
# }

# Use Module Auto Scalling Group
module "asg" {
  source = "./modules/ec2/asg"
  vpc_id = module.vpc.vpc_id
  subnet_db_ids = module.vpc.private_db_subnet_ids
  subnet_app_ids = module.vpc.private_ec2_subnet_ids
  sg_app_ids = module.sg.app_security_group_id
  # availability_zone = var.availability_zone
  volume_size = 30
  target_group_alb_arn = module.alb.tg_apps_alb_arn
  app_instance_type = "t3.nano"
  ami_app_id = "ami-08e4b984abde34a4f"
}

# Use Module Data Life Cycle Manager
module "dlm" {
  source = "./modules/ec2/dlm"
}

# Use Module EFS
module "efs" {
  source = "./modules/efs"
  vpc_id = module.vpc.vpc_id
  subnet_app_ids = module.vpc.private_ec2_subnet_ids
  efs_security_group_id = module.sg.efs_security_group_id
}