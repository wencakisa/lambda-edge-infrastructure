resource "aws_s3_bucket" "bucket" {
  bucket = local.s3_bucket_name
  acl    = "private"

  website {
    index_document = "index.html"
  }

  depends_on = [aws_iam_role.lambda_edge_role]
}
