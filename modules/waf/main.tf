resource "aws_wafv2_web_acl" "web_acl" {
  name        = "example-webacl"
  description = "Example of a managed rule."
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "AWS-AWSManagedRulesCommonRuleSet"
    priority = 0

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        rule_action_override {
          action_to_use {
            count {}
          }

          name = "SizeRestrictions_QUERYSTRING"
        }

        rule_action_override {
          action_to_use {
            count {}
          }

          name = "NoUserAgent_HEADER"
        }

        # scope_down_statement {
        #   geo_match_statement {
        #     country_codes = ["US", "NL"]
        #   }
        # }
      }
    }

    # token_domains = ["mywebsite.com", "myotherwebsite.com"]

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "example-rule-metric-name"
      sampled_requests_enabled   = false
    }
  }

  tags = {
    Name = "Example-Webacl"
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "friendly-metric-name"
    sampled_requests_enabled   = false
  }
}

resource "aws_wafv2_web_acl_association" "alb_association" {
  resource_arn = var.alb_arn
  web_acl_arn  = aws_wafv2_web_acl.web_acl.arn
}