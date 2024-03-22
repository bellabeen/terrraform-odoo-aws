# Output Route 53 zone ID
output "aws_route53_zone_id" {
  value = aws_route53_zone.bellabeen_zone.zone_id
}