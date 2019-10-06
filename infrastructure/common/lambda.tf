# Viewer-request
data "archive_file" "viewer_request_lambda_zip" {
  type        = "zip"
  source_file = "${var.viewer_request_path}/index.js"
  output_path = "${var.viewer_request_path}/lambda.zip"
}

resource "aws_lambda_function" "viewer_request" {
  function_name = "${local.global_prefix}-viewer-request"
  filename      = "${var.viewer_request_path}/lambda.zip"
  handler       = var.default_handler
  runtime       = var.node_runtime_version
  publish       = "true"
  role          = aws_iam_role.lambda_edge_role.arn
}

# Origin-response
data "archive_file" "origin_response_lambda_zip" {
  type        = "zip"
  source_file = "${var.origin_response_path}/index.js"
  output_path = "${var.origin_response_path}/function.zip"
}

resource "aws_lambda_function" "origin_response" {
  function_name = "${local.global_prefix}-origin-response"
  filename      = "${var.origin_response_path}/lambda.zip"
  handler       = var.default_handler
  runtime       = var.node_runtime_version
  publish       = "true"
  role          = aws_iam_role.lambda_edge_role.arn
}
