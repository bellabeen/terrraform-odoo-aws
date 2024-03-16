# Create Segment VPC
resource "aws_vpc" "main" {
  cidr_block = "20.0.0.0/16"

  tags = {
    Name = "VPCMultiSubnet"
  } 
}
