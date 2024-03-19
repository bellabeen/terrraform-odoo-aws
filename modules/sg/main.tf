resource "aws_security_group" "db_security_group" {
  name        = "SG-DB-TEDS-ASP"
  description = "Security group for DB TEDS ASP"
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "open all egress"
    from_port   = 0   # Update from_port to 0 for all protocol
    to_port     = 0   # Update to_port to 0 for all protocol
    protocol    = "-1"
  }

  ingress {
    cidr_blocks = ["172.31.0.0/16"]
    description = "AWS Local"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = ["10.212.133.0/24"]
    description = "SSL VPN Cyber 200F"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
  }

  # Add more ingress rules as needed

  tags = {
    Name = "SG-DB-TEDS-ASP"
  }
}
