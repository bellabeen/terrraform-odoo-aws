terraform {
    cloud {
        organization = "kedaiit-org"
        workspaces {
        name = "learn-tfc-aws"
        }
    }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

# provider "aws" {
#   region = "ap-southeast-1"
#   # Create tags for the all resource add global tagging
#     default_tags {
#       tags = {
#           "tunas:env" = "prod"
#           "tunas:application:id" = "TEDS"
#           "tunas:cost-center" = "TDM"
#     }
#   }
# }

# # Create Segment VPC
# resource "aws_vpc" "main" {
#   cidr_block = "20.0.0.0/16"

#   tags = {
#     Name = "VPCMultiSubnet"
#   } 
# }

# # Create Public Subnet on 3 Availbility Zone
# resource "aws_subnet" "subnet_public" {
#   count = length(var.subnet_public_cidr)
#   vpc_id = aws_vpc.main.id
#   cidr_block = element(var.subnet_public_cidr, count.index)
#   availability_zone = element(var.availability_zone, count.index)
#   tags = {
#     Name = "Public Subnet ${count.index + 1}"
#   }
# }

# # Create Default Internet Gateway
# resource "aws_internet_gateway" "internet_gateway" {
#   vpc_id = aws_vpc.main.id
#   tags   = {
#     Name = "Default IGW"
#   }
# }

# # Integration Subnet Public To Internet Gateway
# resource "aws_route_table" "public_rt" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.internet_gateway.id
#   }

#   tags = {
#     Name = "Public Route Table"
#   }
# }

# # Loop All Integration Subnet Public To Internet Gateway  
# resource "aws_route_table_association" "public_subnet_asso" {
#   count          = length(var.subnet_public_cidr)
#   subnet_id      = element(aws_subnet.subnet_public[*].id, count.index)
#   route_table_id = aws_route_table.public_rt.id
# }

# # Create Private Subnet EC2 On 3 Availbility Zone
# resource "aws_subnet" "subnet_private_ec2" {
#   count            = length(var.subnet_private_ec2_cidr)
#   vpc_id           = aws_vpc.main.id
#   cidr_block       = element(var.subnet_private_ec2_cidr, count.index)
#   availability_zone = element(var.availability_zone, count.index)
#   tags = {
#     Name = "Private Subnet EC2 ${count.index + 1}"
#   }
# }

# # Create Route Table Assosiated Subnet EC2 On 3 Availbility Zone
# resource "aws_route_table" "private_rt" {
#   count = length(var.subnet_private_ec2_cidr)
#   vpc_id = aws_vpc.main.id

#   tags = {
#     Name = "Private Route Table EC2 ${count.index + 1}"
#   }
# }

# # Integration Route Table Private EC2 Assosiated Subnet EC2 On 3 Availbility Zone
# resource "aws_route_table_association" "private_subnet_asso" {
#   count = length(var.subnet_private_ec2_cidr)
#   subnet_id      = aws_subnet.subnet_private_ec2[count.index].id
#   route_table_id = aws_route_table.private_rt[count.index].id
# }

# # Create NAT Gateway
# resource "aws_eip" "nat_eip" {
# }

# # Assosiated Subnet Private EC2 With NAT Gateway
# resource "aws_nat_gateway" "nat_gateway" {
#   allocation_id = aws_eip.nat_eip.id
#   subnet_id     = aws_subnet.subnet_private_ec2[0].id  # Just use the first private subnet for EC2 instances, assuming all private subnets use the same route table
#   tags = {
#     Name = "Default NAT Gateway"
#     # Add more tags as needed
#   }
# }

# resource "aws_route" "private_subnet_route" {
#   count = length(var.subnet_private_ec2_cidr)
#   route_table_id          = aws_route_table.private_rt[count.index].id
#   destination_cidr_block  = "0.0.0.0/0"  # Default route for NAT Gateway
#   # Specify the ID of the NAT Gateway in the gateway_id attribute
#   gateway_id = aws_nat_gateway.nat_gateway.id
# }

# # Create tags for the default route table
# resource "aws_default_route_table" "default_rt" {
#   default_route_table_id = aws_vpc.main.default_route_table_id  # Reference the default route table associated with the VPC

#   tags = {
#     Name = "Default Route Table"
#     # Add more tags as needed
#   }
# }

# # Create Private Subnet DB On 3 Availbility Zone
# resource "aws_subnet" "subnet_private_db" {
#   count            = length(var.subnet_private_db_cidr)
#   vpc_id           = aws_vpc.main.id
#   cidr_block       = element(var.subnet_private_db_cidr, count.index)
#   availability_zone = element(var.availability_zone, count.index)
#   tags = {
#     Name = "Private Subnet DB ${count.index + 1}"
#   }
# }

# # Create Route Table Assosiated Subnet DB On 3 Availbility Zone
# resource "aws_route_table" "private_rt_db" {
#   count = length(var.subnet_private_db_cidr)
#   vpc_id = aws_vpc.main.id

#   tags = {
#     Name = "Private Route Table DB ${count.index + 1}"
#   }
# }

# # Integration Route Table Private DB Assosiated Subnet DB On 3 Availbility Zone
# resource "aws_route_table_association" "private_subnet_db_asso" {
#   subnet_id      = aws_subnet.subnet_private_ec2[0].id  # Assuming you have only one private subnet for EC2 instances
#   route_table_id = aws_route_table.private_rt[0].id
# }