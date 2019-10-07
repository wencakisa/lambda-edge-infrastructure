variable "environment" {
  type        = string
  description = "Environment (staging or production)"
}

variable "app_name" {
  type        = string
  default     = "ms-feeds"
  description = "The application name"
}

variable "lambda_prefix" {
  type        = string
  default     = "image-resize"
  description = "Prefix used for all Lambda functions"
}

variable "node_runtime_version" {
  type        = string
  default     = "nodejs8.10" # Lambda@Edge limitation
  description = "The required Node.js version for Lambda functions"
}

variable "default_handler" {
  type        = string
  default     = "index.handler"
  description = "The default handler of Lambda functions"
}

variable "viewer_request_path" {
  type        = string
  default     = "${path.module}/../src/viewer-request-function"
  description = "Path of the viewer-request function"
}

variable "origin_response_path" {
  type        = string
  default     = "${path.module}/../src/origin-response-function"
  description = "Path of the origin-response function"
}

variable "s3_origin_id" {
  type        = string
  default     = "default-s3-bucket-origin"
  description = "The unique identifier of Cloudfront S3 Bucket origin"
}
