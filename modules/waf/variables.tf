# variable "managed_rules" {
#   description = "A map of managed rules"
#   type        = map(object({
#     name           = string
#     priority       = number
#     excluded_rules = list(string)
#   }))
# }

variable "alb_arn" {
  description = "ARN of the Application Load Balancer (ALB)"
  type        = string
}

# variable "web_acl_arn" {
#   description = "ARN of the Web Application Firewall (WAF) ACL"
#   type        = string
# }
