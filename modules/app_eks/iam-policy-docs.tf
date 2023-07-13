data "aws_iam_policy_document" "node_cloudwatch" {
  statement {
    sid       = "bb2"
    actions   = ["cloudwatch:PutMetricData"]
    effect    = "Allow"
    resources = ["*"]
  }
}


data "aws_iam_policy_document" "node_IMDSv2" {
  statement {
    sid       = "cc3"
    actions   = ["ec2:DescribeInstanceAttribute"]
    effect    = "Allow"
    resources = ["*"]
  }
}

// todo: refactor --> v1.16.3
data "aws_iam_policy_document" "node_kms" {
  statement {
    sid = "dd4"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    effect    = "Allow"
    resources = var.bucket_kms_key_arn == "" || var.bucket_kms_key_arn == null ? ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${aws_iam_role.node.name}"] : [var.bucket_kms_key_arn]
  }
}


// todo: refactor --> v1.16.3
data "aws_iam_policy_document" "node_sqs" {
  statement {
    sid       = "ee5"
    actions   = ["sqs:*"]
    effect    = "Allow"
    resources = var.bucket_sqs_queue_arn == "" || var.bucket_sqs_queue_arn == null ? ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${aws_iam_role.node.name}"] : [var.bucket_sqs_queue_arn]
  }
}


data "aws_iam_policy_document" "node_s3" {
  statement {
    sid     = "ff6"
    actions = ["s3:*"]
    effect  = "Allow"
    resources = [
      "${var.bucket_arn}",
      "${var.bucket_arn}/*"
    ]
  }
}

