resource "aws_security_group" "db_security_group" {
  name        = var.sg_db_name
  description = var.sg_db_description
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = var.aws_local_cidr_blocks
    description = "open all egress"
    from_port   = var.aws_local_from_port
    to_port     = var.aws_local_to_port
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = var.aws_local_cidr_blocks
    description = "AWS Local"
    from_port   = var.aws_local_from_port
    to_port     = var.aws_local_to_port
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = var.ssl_vpn_cidr_blocks
    description = "SSL VPN Access"
    from_port   = var.ssl_vpn_from_port
    to_port     = var.ssl_vpn_to_port
    protocol    = "tcp"
  }

  tags = var.sg_db_tags
}

resource "aws_security_group" "alb_security_group" {
  name        = "SG-ALB-CONTOH"
  description = "Security group for ALB CONTOH"
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "open all egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "All"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = ["172.31.0.0/16"]
    description = "Segment VPC TEDS"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  tags = var.sg_alb_tags
}
