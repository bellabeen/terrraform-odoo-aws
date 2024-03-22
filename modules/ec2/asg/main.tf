resource "aws_launch_template" "contoh_lt" {
  name = "Contoh-WebApp"

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

  iam_instance_profile {
    arn = "arn:aws:iam::030150888082:instance-profile/EC2SsmRole"
  }

  key_name = "test-ec2"
  monitoring {
    enabled = true
  }

  vpc_security_group_ids = [var.sg_app_ids]
  

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "test-instance"
      Environment = "Production"
      "tunas:application-id" = "Contoh"
      # Add more tags as needed
    }
  }

  tag_specifications {
    resource_type = "volume"
    tags = {
      Name        = "test-instance"
      Environment = "Production"
      "tunas:application-id" = "Contoh"
      # Add more tags as needed
    }
  }

  user_data = base64encode(<<EOF
     #!/bin/bash -x
     sudo apt-get -y install unzip
     sudo curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip
     sudo unzip awscliv2.zip
     sudo ./aws/install
     AWS_AVAIL_ZONE=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone)
     AWS_REGION="`echo \"$AWS_AVAIL_ZONE\" | sed 's/[a-z]$//'`"
     AWS_INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
     ROOT_VOLUME_IDS=$(aws ec2 describe-instances --region $AWS_REGION --instance-id $AWS_INSTANCE_ID --output text --query Reservations[0].Instances[0].BlockDeviceMappings[0].Ebs.VolumeId)
     aws ec2 create-tags --resources $ROOT_VOLUME_IDS --region $AWS_REGION --tags Key=Name,Value=TEDS-ASP-WebApp-M5L Key=tunas:env,Value=prod Key=tunas:application-id,Value=TEDS-ASP Key=dlmpolicyTEDS-ASP,Value=Yes Key=tunas:cost-center,Value=ASP Key=map-migrated,Value=d-server-02puwhf6kxy2eb
     EOF
     )

  # user_data = filebase64("${path.module}/example.sh")
}

# resource "aws_autoscaling_group" "contoh_asg" {
#   name               = "Contoh-WebApp"
#   vpc_zone_identifier = var.subnet_app_ids
#   desired_capacity   = 1
#   max_size           = 1
#   min_size           = 1
#   health_check_grace_period = 300
#   health_check_type         = "EC2"

#   launch_template {
#     id      = aws_launch_template.contoh_lt.id
#     version = aws_launch_template.contoh_lt.default_version
#   }

#   target_group_arns = [var.target_group_alb_arn]
# }

# resource "aws_autoscaling_schedule" "ScheduledActionWorkingHours" {
#   scheduled_action_name = "ScheduledActionWorkingHours"
#   autoscaling_group_name = aws_autoscaling_group.AutoScalingGroup.name
#   min_size               = 1
#   max_size               = 2
#   desired_capacity       = 2
#   recurrence             = "0 1 * * MON-FRI"
#   start_time             = "2023-03-28T00:40:00Z"
# }

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