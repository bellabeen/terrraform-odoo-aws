output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "The CIDR of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value = aws_nat_gateway.nat_gateway.id
}

output "route_table_id" {
  description = "Route Table Main Block"
  value = aws_vpc.main.default_route_table_id
}

output "private_ec2_subnet_ids" {
  description = "Private Subnet EC2 CIDR Blocks ID"
  value = aws_subnet.subnet_private_ec2[*].id
}

output "public_subnet_ids" {
  description = "Public Subnet CIDR Block ID"
  value = aws_subnet.subnet_public[*].id
}


output "public_subnet_cidr_blocks" {
  description = "Public Subnet CIDR Blocks"
  value = aws_subnet.subnet_public[*].cidr_block
}

output "private_subnet_cidr_blocks" {
  description = "Private Subnet DB CIDR Blocks"
  value = aws_subnet.subnet_private_db[*].cidr_block
}

output "private_db_subnet_ids" {
  description = "Private Subnet DB CIDR Blocks ID"
  value = aws_subnet.subnet_private_db[*].id
}

output "availability_zones" {
  description = "Availability Zone"
  value = aws_subnet.subnet_private_ec2[*].availability_zone
}

# output "availability_zone_ids" {
#   description = "Availability Zone ID"
#   value = 
# }