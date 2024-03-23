# Create IAM Role For DLM
resource "aws_iam_role" "dlm_monitoring_role" {
  name               = "AWSDataLifecycleManagerDefaultRole"
  description        = "Allow Data Lifecycle Manager to create and manage AWS resources on your behalf."
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "dlm.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
  })
}

# Create IAM Policy DLM
resource "aws_iam_policy_attachment" "dlm_monitoring_attachment" {
  name       = "dlm-monitoring-attachment"
  roles      = [aws_iam_role.dlm_monitoring_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSDataLifecycleManagerServiceRole"
}

# Create DLM Policy
resource "aws_dlm_lifecycle_policy" "lifecycle_policy" {
  description = "Lifecycle Policy Example using Terraform"
  state       = "ENABLED"
  # execution_role_arn = "arn:aws:iam::030150888082:role/test_dlm"
  execution_role_arn = aws_iam_role.dlm_monitoring_role.arn

   policy_details {
    resource_types = ["VOLUME"]

    schedule {
      name = "Example Daily Snapshots"

      create_rule {
        interval      = 24
        interval_unit = "HOURS"
        times         = ["23:45"]
      }

      retain_rule {
        interval      = 7
        interval_unit = "DAYS"
      }

    #   tags_to_add = {
    #     SnapshotCreator = "DLM"
    #   }

      copy_tags = true
    }

    target_tags = {
      "dlmpolicyExample"   = "Yes"
    }
  }

  tags = {
    "Name"                 = "DLM-Example"
  }
}