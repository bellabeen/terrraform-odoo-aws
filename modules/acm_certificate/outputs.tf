# Output ACM certificate ARN
output "acm_certificate_arn" {
  value = aws_acm_certificate.bellabeen.arn
}
