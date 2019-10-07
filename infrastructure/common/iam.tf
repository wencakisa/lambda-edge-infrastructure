# IAM Role

data "aws_iam_policy_document" "lambda_edge_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_edge_role" {
  name               = "${local.global_prefix}-lambda-edge-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_edge_policy_document.json
}

# Bucket policy

data "aws_iam_policy_document" "bucket_policy_document" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${local.s3_bucket_name}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::${local.s3_bucket_name}"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }

  statement {
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${local.s3_bucket_name}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.lambda_edge_role.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.bucket_policy_document.json
}
