variable "environment" {
  type = string
}

variable "app_name" {
  type = string
  default = "ms-feeds"
}

variable "lambda_prefix" {
  type = string
  default = "image-resize"
}

variable "node_runtime_version" {
  type = string
  default = "nodejs8.10"  # Lambda@Edge limitation
}

variable "default_handler" {
  type = string
  default = "index.handler"
}

variable "viewer_request_path" {
  type = string
  default = "${path.module}/../src/viewer-request"
}

variable "origin_response_path" {
  type = string
  default = "${path.module}/../src/origin-response"
}

variable "s3_origin_id" {
  type = string
  default = "default-s3-bucket-origin"
}
