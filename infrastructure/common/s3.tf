resource "aws_s3_bucket" "bucket" {
  bucket = "${var.app_name}-${var.environment}-bucket"
  acl    = "public-read"
  policy = file("${path.module}/../definitions/bucket_policy.json")

  website {
    index_document = "index.html"
  }
}
