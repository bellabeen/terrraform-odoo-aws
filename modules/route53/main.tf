# resource "aws_route53_zone" "bellabeen_zone" {
#   name = "bellabeen.com"
# }

# data "aws_route53_zone" "bellabeen" {
#   name         = "bellabeen.com"
#   private_zone = false
# }

# resource "aws_route53_record" "bellabeen_cert_dns" {
#   for_each = {
#     for domain_validation_options in aws_acm_certificate.bellabeen.domain_validation_options : domain_validation_options.resource_record_name => {
#       name    = domain_validation_options.resource_record_name
#       records = [domain_validation_options.resource_record_value]
#       ttl     = 60
#       type    = domain_validation_options.resource_record_type
#     }
#   }

#   zone_id = data.aws_route53_zone.bellabeen.zone_id
#   name    = each.value.name
#   records = each.value.records
#   ttl     = each.value.ttl
#   type    = each.value.type
# }


# Create Route 53 zone for bellabeen.com
resource "aws_route53_zone" "bellabeen_zone" {
  name = "bellabeen.com"
  comment = "Public Route 53 zone for bellabeen.com"
  force_destroy = false  # This allows Terraform to destroy the zone and all its records
}
