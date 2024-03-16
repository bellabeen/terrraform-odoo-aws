# output "id" {
#   description = "CIDR Block"
#   value = aws_vpc.main.id
# }

# output "route_table_id" {
#   description = "Route Table Main Block"
#   value = aws_vpc.main.default_route_table_id
# }

# # output "default_route_table_id" {
# #   description = "Route Table Main Block"
# #   value = data.aws_default_route_table.default.id
# # }

# output "private_subnet_ids" {
#   description = "Private Subnet EC2 CIDR Blocks"
#   value = aws_subnet.subnet_private_ec2[*].id
# }

# # output "private_subnet_cidr_blocks" {
# #   value = aws_subnet.subnet_private_ec2[*].cidr_block
# # }

# output "private_subnet_cidr_blocks" {
#   description = "Private Subnet DB CIDR Blocks"
#   value = aws_subnet.subnet_private_db[*].cidr_block
# }

# output "private_subnet_availability_zones" {
#   description = "Private Availability Zone"
#   value = aws_subnet.subnet_private_ec2[*].availability_zone
# }

