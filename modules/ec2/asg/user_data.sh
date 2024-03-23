#!/bin/bash -x
sudo apt-get -y install unzip
sudo curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip
sudo unzip awscliv2.zip
sudo ./aws/install
AWS_AVAIL_ZONE=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone)
AWS_REGION="`echo \"$AWS_AVAIL_ZONE\" | sed 's/[a-z]$//'`"
AWS_INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
ROOT_VOLUME_IDS=$(aws ec2 describe-instances --region $AWS_REGION \
  --instance-id $AWS_INSTANCE_ID \
  --output text --query Reservations[0].Instances[0].BlockDeviceMappings[0].Ebs.VolumeId)