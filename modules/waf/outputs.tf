output "web_acl_id" {
  value = aws_wafv2_web_acl.web_acl.id
}

output "web_acl_arn_output" {
  value = aws_wafv2_web_acl.web_acl.arn
}

output "alb_arn" {
  value = aws_wafv2_web_acl_association.alb_association.web_acl_arn
}

output "web_acl_association_arn" {
  value = aws_wafv2_web_acl_association.alb_association.web_acl_arn
}