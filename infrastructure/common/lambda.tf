# Viewer-request
data "archive_file" "viewer_request_lambda_zip" {
  type        = "zip"
  source_file = "${local.viewer_request_path}/index.js"
  output_path = "${local.viewer_request_path}/lambda.zip"
}

resource "aws_lambda_function" "viewer_request" {
  function_name = "${local.global_prefix}-viewer-request"
  filename      = "${local.viewer_request_path}/lambda.zip"
  handler       = var.default_handler
  runtime       = var.node_runtime_version
  publish       = true
  role          = aws_iam_role.lambda_edge_role.arn
}

# Origin-response

# IMPORTANT:

# Terraform's `archive_file` has a still unresolved bug
# when archiving symbolic links.
# https://github.com/terraform-providers/terraform-provider-archive/issues/6

# We need symlinks for the Sharp library that resizes our images
# https://github.com/lovell/sharp/issues/1885

# data "archive_file" "origin_response_lambda_zip" {
#   type        = "zip"
#   source_dir  = local.origin_response_path
#   output_path = "${local.origin_response_path}/lambda.zip"
# }

resource "aws_lambda_function" "origin_response" {
  function_name = "${local.global_prefix}-origin-response"
  filename      = "${local.origin_response_path}/lambda.zip"
  handler       = var.default_handler
  runtime       = var.node_runtime_version
  publish       = true
  role          = aws_iam_role.lambda_edge_role.arn
  memory_size   = 3008
  timeout       = 30
}
