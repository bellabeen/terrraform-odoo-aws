# # Create Route 53 zone for bellabeen.com
# resource "aws_route53_zone" "bellabeen_zone" {
#   name = "bellabeen.com"
#   comment = "Route 53 zone for bellabeen.com"
#   tags = {
#     Environment = "Production"
#     Owner       = "Your Name"
#   }
# }

# # Retrieve the created Route 53 zone
# data "aws_route53_zone" "bellabeen" {
#   name         = var.aws_route53_zone
#   private_zone = false
# }


# # Create ACM certificate for bellabeen.com
# resource "aws_acm_certificate" "bellabeen" {
#   domain_name       = "bellabeen.com"
#   validation_method = "DNS"

#   # Specify DNS validation options
#   lifecycle {
#     create_before_destroy = true
#   }

#   tags = {
#     Name = "bellabeen.com-cert"
#   }
# }

# # Create Route 53 records for ACM certificate DNS validation
# resource "aws_route53_record" "bellabeen_cert_dns" {
#   for_each = {
#     for idx, domain_validation_option in aws_acm_certificate.bellabeen.domain_validation_options : idx => {
#       name    = domain_validation_option.resource_record_name
#       records = [domain_validation_option.resource_record_value]
#       ttl     = 60
#       type    = domain_validation_option.resource_record_type
#     }
#   }

#   zone_id = data.aws_route53_zone.bellabeen.zone_id
#   name    = each.value.name
#   records = each.value.records
#   ttl     = each.value.ttl
#   type    = each.value.type
# }