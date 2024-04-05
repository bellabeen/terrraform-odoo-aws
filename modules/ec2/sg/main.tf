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

  dynamic "ingress" {
      for_each = var.subnet_ids
      content {
        cidr_blocks = [ingress.value]
        from_port   = var.aws_local_from_db_port
        to_port     = var.aws_local_to_db_port
        protocol    = var.aws_local_protocol_tcp
        description = "Allow traffic from EC2 Private Subnet to database"
        # description = "Allow traffic from ${data.aws_subnet.subnets[ingress.value].tags.Name} to database"
      }
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

data "aws_subnet" "subnets" {
  for_each = toset(var.subnet_ids)
  vpc_id   = var.vpc_id
  tags     = { Name = "Private Subnet App A" }  # Default name to avoid errors, update accordingly
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

  # dynamic "ingress" {
  #     for_each = var.subnet_ids
  #     content {
  #       cidr_blocks = [ingress.value]
  #       from_port   = var.aws_local_from_https_port
  #       to_port     = var.aws_local_to_https_port
  #       protocol    = "tcp"
  #       description = "Allow traffic from EC2 Private Subnet to database"
  #       # description = "Allow traffic from ${data.aws_subnet.subnets[ingress.value].tags.Name} to database"
  #     }
  # }

  # ingress {
  #   cidr_blocks = var.aws_local_cidr_blocks
  #   description = var.aws_local_to_http_description
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  # }

   dynamic "ingress" {
      for_each = var.subnet_ids
      content {
        cidr_blocks = [ingress.value]
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        description = "All Private EC2 Subnet access ALB from http"
        # description = "Allow traffic from ${data.aws_subnet.subnets[ingress.value].tags.Name} to database"
      }
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

  # ingress {
  #   cidr_blocks = var.aws_local_cidr_blocks
  #   description = var.aws_local_description
  #   from_port   = var.aws_local_from_xmlrpc_port
  #   to_port     = var.aws_local_to_xmlrpc_port
  #   protocol    = var.aws_local_protocol_tcp
  # }

  dynamic "ingress" {
      for_each = var.subnet_ids
      content {
        cidr_blocks = [ingress.value]
        from_port   = var.aws_local_from_xmlrpc_port
        to_port     = var.aws_local_to_xmlrpc_port
        protocol    = var.aws_local_protocol_tcp
        description = "All Private EC2 Subnet access from xmlrpc port"
      }
  }

  # ingress {
  #   cidr_blocks = var.aws_local_cidr_blocks
  #   description = var.aws_local_description
  #   from_port   = var.aws_local_from_port_ssh
  #   to_port     = var.aws_local_to_port_ssh
  #   protocol    = var.aws_local_protocol_tcp
  # }

    dynamic "ingress" {
      for_each = var.subnet_ids
      content {
        cidr_blocks = [ingress.value]
        from_port   = var.aws_local_from_port_ssh
        to_port     = var.aws_local_to_port_ssh
        protocol    = var.aws_local_protocol_tcp
        description = "All Private EC2 Subnet access ALB from ssh port"
      }
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

  # ingress {
  #   cidr_blocks = var.aws_local_cidr_blocks
  #   description = "from EC2 Subnet Avaibility Zone"
  #   from_port   = 2049
  #   to_port     = 2049
  #   protocol    = "tcp"
  # }

    dynamic "ingress" {
      for_each = var.subnet_ids
      content {
        cidr_blocks = [ingress.value]
        from_port   = 2049
        to_port     = 2049
        protocol    = var.aws_local_protocol_tcp
        description = "From Private EC2 Subnet Avaibility Zone"
      }
  }

# FIX: reference another Security Group ID
  ingress {
    description = "From Security Group App ID"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    security_groups = ["${aws_security_group.app_security_group.id}"]
  }
  tags = var.sg_efs_tags
}