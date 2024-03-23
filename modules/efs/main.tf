# Create EFS Data
resource "aws_efs_file_system" "efs_data" {
  encrypted           = true
  performance_mode    = "maxIO"
  throughput_mode     = "bursting" # Valid values: bursting, provisioned, or elastic
  # TODO: When using provisioned, also set provisioned_throughput_in_mibps
  # provisioned_throughput_in_mibps = "10"
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
  tags = {
    Name                  = "example-efs-data"
    map-migrated          = "d-server-01v3qssq49cbdd"
    map-migrated-app      = "nfs.asp"
  }
}

# Mount EFS Data
resource "aws_efs_mount_target" "mount_target_data" {
  count          = length(var.subnet_app_ids)
  file_system_id = aws_efs_file_system.efs_data.id
  subnet_id     = var.subnet_app_ids[count.index]
  security_groups = [var.efs_security_group_id]
}

# Data for Policy EFS Data
data "aws_iam_policy_document" "policy_data" {
  statement {
    sid    = "efs-statement-cf"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "elasticfilesystem:ClientMount",
      "elasticfilesystem:ClientWrite",
      "elasticfilesystem:ClientRootAccess"
    ]

    resources = [aws_efs_file_system.efs_data.arn]
    condition {
      test     = "Bool"
      variable = "elasticfilesystem:AccessedViaMountTarget"
      values   = ["true"]
      
    }
  }

  statement {
    sid    = "efs-statement-iam-role"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::030150888082:role/EC2SsmRole"]
    }

    actions = [
      "elasticfilesystem:ClientMount",
      "elasticfilesystem:ClientWrite",
      "elasticfilesystem:ClientRootAccess"
    ]

    resources = [aws_efs_file_system.efs_data.arn]
    condition {
      test     = "Bool"
      variable = "elasticfilesystem:AccessedViaMountTarget"
      values   = ["true"]
      
    }
  }
}

# Create Policy EFS Data
resource "aws_efs_file_system_policy" "policy_data" {
  file_system_id = aws_efs_file_system.efs_data.id
  policy         = data.aws_iam_policy_document.policy_data.json
}

# Create access point EFS Data
resource "aws_efs_access_point" "access_point_data" {
  file_system_id = aws_efs_file_system.efs_data.id
  root_directory {
    path = "/"
  }
  tags = {
    Name                  = "/opt/example_data/"
  }
}

# Create Policy Backup Automatic EFS Data
resource "aws_efs_backup_policy" "policy_backup_data" {
  file_system_id = aws_efs_file_system.efs_data.id

  backup_policy {
    status = "ENABLED"
  }
}

# Create EFS Code
resource "aws_efs_file_system" "efs_code" {
  encrypted           = true
  performance_mode    = "maxIO"
  throughput_mode     = "bursting" # Valid values: bursting, provisioned, or elastic
  # TODO: When using provisioned, also set provisioned_throughput_in_mibps
  # provisioned_throughput_in_mibps = "10"
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
  tags = {
    Name                  = "example-efs-code"
    map-migrated          = "d-server-01v3qssq49cbdd"
    map-migrated-app      = "nfs.asp"
  }
}

# Mount EFS Code
resource "aws_efs_mount_target" "mount_target_code" {
  count          = length(var.subnet_app_ids)
  file_system_id = aws_efs_file_system.efs_code.id
  subnet_id     = var.subnet_app_ids[count.index]
  security_groups = [var.efs_security_group_id]
}

# Data for Policy EFS Code
data "aws_iam_policy_document" "policy_code" {
  statement {
    sid    = "efs-statement-cf"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "elasticfilesystem:ClientMount",
      "elasticfilesystem:ClientWrite",
      "elasticfilesystem:ClientRootAccess"
    ]

    resources = [aws_efs_file_system.efs_code.arn]
    condition {
      test     = "Bool"
      variable = "elasticfilesystem:AccessedViaMountTarget"
      values   = ["true"]
      
    }
  }

  statement {
    sid    = "efs-statement-iam-role"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::030150888082:role/EC2SsmRole"]
    }

    actions = [
      "elasticfilesystem:ClientMount",
      "elasticfilesystem:ClientWrite",
      "elasticfilesystem:ClientRootAccess"
    ]

    resources = [aws_efs_file_system.efs_code.arn]
    condition {
      test     = "Bool"
      variable = "elasticfilesystem:AccessedViaMountTarget"
      values   = ["true"]
      
    }
  }
}

# Create Policy EFS Code
resource "aws_efs_file_system_policy" "policy_code" {
  file_system_id = aws_efs_file_system.efs_code.id
  policy         = data.aws_iam_policy_document.policy_code.json
}

# Create access point EFS Code
resource "aws_efs_access_point" "access_point_code" {
  file_system_id = aws_efs_file_system.efs_code.id
  root_directory {
    path = "/"
  }
  tags = {
    Name                  = "/opt/code_code/"
  }
}

# Create Policy Backup Automatic EFS Code
resource "aws_efs_backup_policy" "policy_backup_code" {
  file_system_id = aws_efs_file_system.efs_code.id

  backup_policy {
    status = "ENABLED"
  }
}

# Create EFS Session
resource "aws_efs_file_system" "efs_session" {
  encrypted           = true
  performance_mode    = "maxIO"
  throughput_mode     = "bursting" # Valid values: bursting, provisioned, or elastic
  # TODO: When using provisioned, also set provisioned_throughput_in_mibps
  # provisioned_throughput_in_mibps = "10"
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
  tags = {
    Name                  = "example-efs-session"
    map-migrated          = "d-server-01v3qssq49cbdd"
    map-migrated-app      = "nfs.asp"
  }
}

# Mount EFS Session
resource "aws_efs_mount_target" "mount_target_session" {
  count          = length(var.subnet_app_ids)
  file_system_id = aws_efs_file_system.efs_session.id
  subnet_id     = var.subnet_app_ids[count.index]
  security_groups = [var.efs_security_group_id]
}

# Data for Policy EFS Session
data "aws_iam_policy_document" "policy_session" {
  statement {
    sid    = "efs-statement-cf"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "elasticfilesystem:ClientMount",
      "elasticfilesystem:ClientWrite",
      "elasticfilesystem:ClientRootAccess"
    ]

    resources = [aws_efs_file_system.efs_session.arn]
    condition {
      test     = "Bool"
      variable = "elasticfilesystem:AccessedViaMountTarget"
      values   = ["true"]
      
    }
  }

  statement {
    sid    = "efs-statement-iam-role"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::030150888082:role/EC2SsmRole"]
    }

    actions = [
      "elasticfilesystem:ClientMount",
      "elasticfilesystem:ClientWrite",
      "elasticfilesystem:ClientRootAccess"
    ]

    resources = [aws_efs_file_system.efs_session.arn]
    condition {
      test     = "Bool"
      variable = "elasticfilesystem:AccessedViaMountTarget"
      values   = ["true"]
      
    }
  }
}

# Create Policy EFS Session
resource "aws_efs_file_system_policy" "policy_session" {
  file_system_id = aws_efs_file_system.efs_session.id
  policy         = data.aws_iam_policy_document.policy_session.json
}

# Create access point EFS Session
resource "aws_efs_access_point" "access_point_session" {
  file_system_id = aws_efs_file_system.efs_session.id
  root_directory {
    path = "/"
  }
  tags = {
    Name                  = "/opt/example_session/"
  }
}

# Create Policy Backup Automatic EFS Session
resource "aws_efs_backup_policy" "policy_backup_session" {
  file_system_id = aws_efs_file_system.efs_session.id

  backup_policy {
    status = "ENABLED"
  }
}