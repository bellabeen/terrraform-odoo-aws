# Create ACM certificate for bellabeen.com
resource "aws_acm_certificate" "bellabeen" {
 domain_name       = "bellabeen.com"
  subject_alternative_names = ["*.bellabeen.com"]
  validation_method = "DNS"

  # Specify DNS validation options
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "bellabeen.com-cert"
  }
}