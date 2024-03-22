output "tg_apps_alb_arn" {
  value = aws_lb_target_group.tg_apps.arn
}

output "alb_arn" {
  value = aws_lb.alb.arn
}
