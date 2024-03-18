# Create Segment VPC
resource "aws_vpc" "main" {
  cidr_block = "20.0.0.0/16"

  tags = {
    Name = "VPCMultiSubnet"
  } 
}

# Create Public Subnet on 3 Availbility Zone
resource "aws_subnet" "subnet_public" {
  count = length(var.subnet_public_cidr)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.subnet_public_cidr, count.index)
  availability_zone = element(var.availability_zone, count.index)
  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

# Create Default Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id
  tags   = {
    Name = "Default IGW"
  }
}

# Integration Subnet Public To Internet Gateway
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

# Loop All Integration Subnet Public To Internet Gateway  
resource "aws_route_table_association" "public_subnet_asso" {
  count          = length(var.subnet_public_cidr)
  subnet_id      = element(aws_subnet.subnet_public[*].id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

# Create Private Subnet EC2 On 3 Availbility Zone
resource "aws_subnet" "subnet_private_ec2" {
  count            = length(var.subnet_private_ec2_cidr)
  vpc_id           = aws_vpc.main.id
  cidr_block       = element(var.subnet_private_ec2_cidr, count.index)
  availability_zone = element(var.availability_zone, count.index)
  tags = {
    Name = "Private Subnet App ${count.index + 1}"
  }
}

# Create Route Table Assosiated Subnet EC2 On 3 Availbility Zone
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Private Route Table for App"
  }
}
# Integration Route Table Private EC2 Assosiated Subnet EC2 On 3 Availbility Zone
resource "aws_route_table_association" "private_subnet_asso" {
  count          = length(aws_subnet.subnet_private_ec2)
  subnet_id      = aws_subnet.subnet_private_ec2[count.index].id
  route_table_id = aws_route_table.private_rt.id
}

# Create NAT Gateway
resource "aws_eip" "nat_eip" {
}

# Assosiated Subnet Private EC2 With NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.subnet_public[0].id  # Assuming you want to use the first private subnet for EC2 instances with NAT Gateway
  tags = {
    Name = "Default NAT Gateway"
    # Add more tags as needed
  }
}


resource "aws_route" "private_subnet_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"  # Default route for NAT Gateway
  gateway_id             = aws_nat_gateway.nat_gateway.id
}

# Create Private Subnet DB On 3 Availbility Zone
resource "aws_subnet" "subnet_private_db" {
  count            = length(var.subnet_private_db_cidr)
  vpc_id           = aws_vpc.main.id
  cidr_block       = element(var.subnet_private_db_cidr, count.index)
  availability_zone = element(var.availability_zone, count.index)
  tags = {
    Name = "Private Subnet DB ${count.index + 1}"
  }
}

# Create Route Table Assosiated Subnet DB On 3 Availbility Zone
resource "aws_route_table" "private_rt_db" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Private Route Table for DB"
  }
}

# Integration Route Table Private DB Assosiated Subnet DB On 3 Availbility Zone
resource "aws_route_table_association" "private_subnet_db_asso" {
  count          = length(var.subnet_private_db_cidr)
  subnet_id      = aws_subnet.subnet_private_db[count.index].id
  route_table_id = aws_route_table.private_rt_db.id
}