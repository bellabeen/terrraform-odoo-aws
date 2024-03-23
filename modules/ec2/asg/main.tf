# Create Launch Template
resource "aws_launch_template" "example_lt" {
  name = "Example-WebApp"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = var.volume_size
      volume_type = "gp3"
      delete_on_termination = true
      encrypted = true
    }
  }

  image_id = var.ami_app_id
  instance_type = var.app_instance_type
  key_name = "test-ec2"
  vpc_security_group_ids = [var.sg_app_ids]
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  iam_instance_profile {
    arn = "arn:aws:iam::030150888082:instance-profile/EC2SsmRole"
  }

  monitoring {
    enabled = true
  }
  
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "Example-Apps"
      "company:env" = "production"
      "company:application-id" = "Example"
      "company:cost-center" = "IT"
      "created:by" = "Terraform"
      "dlmpolicyExample" = "Yes"
    }
  }

  tag_specifications {
    resource_type = "volume"
    tags = {
      Name        = "Example-Apps"
      "company:env" = "production"
      "company:application-id" = "Example"
      "company:cost-center" = "IT"
      "created:by" = "Terraform"
      "dlmpolicyExample" = "Yes"
    }
  }

  user_data = filebase64("${path.module}/user_data.sh")
}

# Create Auto Scalling Group
resource "aws_autoscaling_group" "example_asg" {
  name               = "Example-WebApp"
  vpc_zone_identifier = var.subnet_app_ids
  desired_capacity   = 2
  max_size           = 2
  min_size           = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"

  launch_template {
    id      = aws_launch_template.example_lt.id
    version = aws_launch_template.example_lt.default_version
  }

  target_group_arns = [var.target_group_alb_arn]

  tag {
    key                 = "Name"
    value               = "Example-Apps"
    propagate_at_launch = true
  }

  tag {
    key                 = "dlmpolicyExample"
    value               = "Yes"
    propagate_at_launch = true
  }

  tag {
    key                 = "company:env"
    value               = "production"
    propagate_at_launch = true
  }

  tag {
    key                 = "company:application-id"
    value               = "Example"
    propagate_at_launch = true
  }

  tag {
    key                 = "company:cost-center"
    value               = "IT"
    propagate_at_launch = true
  }

  tag {
    key                 = "created:by"
    value               = "Terraform"
    propagate_at_launch = true
  }

}

# Create ASG Schedule
resource "aws_autoscaling_schedule" "ScheduledActionWorkingHours" {
  scheduled_action_name = "ScheduledActionWorkingHours"
  autoscaling_group_name = aws_autoscaling_group.example_asg.name
  min_size               = 1
  max_size               = 2
  desired_capacity       = 2
  recurrence             = "0 1 * * MON-FRI"
  start_time             = "2024-03-24T00:40:00Z"
}

# resource "aws_autoscaling_schedule" "ScheduledActionNonWorkingHours" {
#   scheduled_action_name = "ScheduledActionNonWorkingHours"
#   autoscaling_group_name = aws_autoscaling_group.AutoScalingGroup.name
#   min_size               = 1
#   max_size               = 2
#   desired_capacity       = 1
#   recurrence             = "45 10 6-25 * *"
#   start_time             = "2023-03-28T10:45:00Z"
# }

# resource "aws_autoscaling_schedule" "ScheduledActionWorkingHoursSunday" {
#   scheduled_action_name = "ScheduledActionWorkingHoursSunday"
#   autoscaling_group_name = aws_autoscaling_group.AutoScalingGroup.name
#   min_size               = 1
#   max_size               = 2
#   desired_capacity       = 2
#   recurrence             = "0 1 * * SUN"
#   start_time             = "2023-04-26T12:45:00Z"
# }