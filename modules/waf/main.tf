resource "aws_wafv2_web_acl" "web_acl" {
  name        = "teds-asp-webacl"
  description = "TEDS ASP Web ACL"

  default_action {
    allow {} // or block {}
  }

  scope = "REGIONAL"

  visibility_config {
    sampled_requests_enabled   = true
    cloudwatch_metrics_enabled = true
    metric_name                = "TEDS-ASP-webacl"
  }

#   dynamic "rule" {
#     for_each = var.managed_rules
#     content {
#       name = rule.value.name
#       priority = rule.value.priority

#       override_action {
#         count {}
#       }

#       visibility_config {
#         sampled_requests_enabled   = true
#         cloudwatch_metrics_enabled = true
#         metric_name                = "AWS-AWSManagedRulesCommonRuleSet"
#       }

#       statement {
#         managed_rule_group_statement {
#           vendor_name = "AWS"
#           name        = rule.value.name
          
#           dynamic "excluded_rule" {
#             for_each = rule.value.excluded_rules
#             content {
#               name = excluded_rule.value
#             }
#           }
#         }
#       }
#     }
#   }

  tags = {
    "tunas:application-id" = "TEDS-ASP"
    "tunas:cost-center"    = "ASP"
    "Project"               = "TEDS ASP on AWS"
    "tunas:env"             = "prod"
    "created:by"            = "Terraform"
  }
}

resource "aws_wafv2_web_acl_association" "alb_association" {
  resource_arn = var.alb_arn
  web_acl_arn  = aws_wafv2_web_acl.web_acl.arn
}