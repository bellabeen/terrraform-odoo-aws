output "target_group_app_alb" {
  value = aws_lb_target_group.tg.arn
}

output "alb_app" {
  value = aws_lb.alb.arn
}
