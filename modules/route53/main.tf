# Create Route 53 zone for bellabeen.com
# TODO: uncomment if you create hosted zone
# resource "aws_route53_zone" "bellabeen_zone" {
#   name    = "bellabeen.com"
#   comment = "Route 53 zone for bellabeen.com"
#   tags = {
#     Environment = "Production"
#     Owner       = "Your Name"
#   }
# }