locals {
  global_prefix = "${var.app_name}-${var.environment}-${var.lambda_prefix}"

  lambda_folder        = "${path.module}/../../src"
  viewer_request_path  = "${local.lambda_folder}/viewer-request-function"
  origin_response_path = "${local.lambda_folder}/origin-response-function"

  s3_bucket_name = "${var.app_name}-${var.environment}-s3-bucket"
}
