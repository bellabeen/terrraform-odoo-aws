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
    Name                  = "contoh-efs-data"
    map-migrated          = "d-server-01v3qssq49cbdd"
    map-migrated-app      = "nfs.asp"
  }
}

resource "aws_efs_mount_target" "mount_target_data" {
  count          = length(var.subnet_app_ids)
  file_system_id = aws_efs_file_system.efs_data.id
  subnet_id     = var.subnet_app_ids[count.index]
  security_groups = [var.efs_security_group_id]
}

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

resource "aws_efs_file_system_policy" "policy_data" {
  file_system_id = aws_efs_file_system.efs_data.id
  policy         = data.aws_iam_policy_document.policy_data.json
}

resource "aws_efs_access_point" "access_point_data" {
  file_system_id = aws_efs_file_system.efs_data.id
  root_directory {
    path = "/"
  }
  tags = {
    Name                  = "/opt/contoh_data/"
  }
}



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
    Name                  = "contoh-efs-code"
    map-migrated          = "d-server-01v3qssq49cbdd"
    map-migrated-app      = "nfs.asp"
  }
}

resource "aws_efs_mount_target" "mount_target_code" {
  count          = length(var.subnet_app_ids)
  file_system_id = aws_efs_file_system.efs_code.id
  subnet_id     = var.subnet_app_ids[count.index]
  security_groups = [var.efs_security_group_id]
}

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

resource "aws_efs_file_system_policy" "policy_code" {
  file_system_id = aws_efs_file_system.efs_code.id
  policy         = data.aws_iam_policy_document.policy_code.json
}

resource "aws_efs_access_point" "access_point_code" {
  file_system_id = aws_efs_file_system.efs_code.id
  root_directory {
    path = "/"
  }
  tags = {
    Name                  = "/opt/code_code/"
  }
}

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
    Name                  = "contoh-efs-session"
    map-migrated          = "d-server-01v3qssq49cbdd"
    map-migrated-app      = "nfs.asp"
  }
}

resource "aws_efs_mount_target" "mount_target_session" {
  count          = length(var.subnet_app_ids)
  file_system_id = aws_efs_file_system.efs_session.id
  subnet_id     = var.subnet_app_ids[count.index]
  security_groups = [var.efs_security_group_id]
}

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

resource "aws_efs_file_system_policy" "policy_session" {
  file_system_id = aws_efs_file_system.efs_session.id
  policy         = data.aws_iam_policy_document.policy_session.json
}

resource "aws_efs_access_point" "access_point_session" {
  file_system_id = aws_efs_file_system.efs_session.id
  root_directory {
    path = "/"
  }
  tags = {
    Name                  = "/opt/contoh_session/"
  }
}