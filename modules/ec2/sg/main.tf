resource "aws_security_group" "db_security_group" {
  name        = var.sg_db_name
  description = var.sg_db_description
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = var.all_access_cidr_block_egress
    description = var.all_description_egress
    from_port   = var.aws_local_from_db_port
    to_port     = var.aws_local_to_db_port
    protocol    = var.aws_local_protocol_tcp
  }

  ingress {
    cidr_blocks = var.aws_local_cidr_blocks
    description = var.aws_local_description
    from_port   = var.aws_local_from_db_port
    to_port     = var.aws_local_to_db_port
    protocol    = var.aws_local_protocol_tcp
  }

  ingress {
    cidr_blocks = var.ssl_vpn_ho_cidr_blocks
    description = var.ssl_vpn_ho_description
    from_port   = var.ssl_vpn_from_db_port
    to_port     = var.ssl_vpn_to_db_port
    protocol    = var.aws_local_protocol_tcp
  }

  tags = var.sg_db_tags
}

resource "aws_security_group" "alb_security_group" {
  name        = var.sg_alb_name
  description = var.sg_alb_description
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = var.all_access_egress
    description = var.all_description_egress
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  ingress {
    cidr_blocks = var.aws_all_cidr_blocks
    description = var.aws_local_to_https_description
    from_port   = var.aws_local_from_https_port
    to_port     = var.aws_local_to_https_port
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = var.aws_local_cidr_blocks
    description = var.aws_local_to_http_description
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  tags = var.sg_alb_tags
}

resource "aws_security_group" "app_security_group" {
  name        = var.sg_app_name
  description = var.sg_app_description
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = var.all_access_egress
    description = var.all_description_egress
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  ingress {
    cidr_blocks = var.aws_local_cidr_blocks
    description = var.aws_local_description
    from_port   = var.aws_local_from_xmlrpc_port
    to_port     = var.aws_local_to_xmlrpc_port
    protocol    = var.aws_local_protocol_tcp
  }

    ingress {
    cidr_blocks = var.aws_local_cidr_blocks
    description = var.aws_local_description
    from_port   = var.aws_local_from_port_ssh
    to_port     = var.aws_local_to_port_ssh
    protocol    = var.aws_local_protocol_tcp
  }

    ingress {
    cidr_blocks = var.ssl_vpn_ho_cidr_blocks
    description = var.ssl_vpn_ho_description
    from_port   = var.aws_local_from_port_icmp
    to_port     = var.aws_local_to_port_icmp
    protocol    = var.aws_local_protocol_icmp
  }

  tags = var.sg_app_tags
}

resource "aws_security_group" "efs_security_group" {
  name        = var.sg_efs_name
  description = var.sg_efs_description
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "var.all_description_egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  ingress {
    cidr_blocks = var.efs_ingress_cidr_blocks
    description = "from EC2 Subnet Avaibility Zone"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
  }

  tags = var.sg_efs_tags
}

resource "aws_security_group_rule" "efs_ingress_app" {
  depends_on               = [aws_security_group.efs_security_group]
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app_security_group.id
  security_group_id        = aws_security_group.efs_security_group.id
}

resource "aws_security_group_rule" "app_ingress_efs" {
  depends_on               = [aws_security_group.efs_security_group]
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.efs_security_group.id
  security_group_id        = aws_security_group.app_security_group.id
}