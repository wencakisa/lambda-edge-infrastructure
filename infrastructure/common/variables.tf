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
  default     = "nodejs10.x" # Lambda@Edge limitation
  description = "The required Node.js version for Lambda functions"
}

variable "default_handler" {
  type        = string
  default     = "index.handler"
  description = "The default handler of Lambda functions"
}

variable "s3_origin_id" {
  type        = string
  default     = "default-s3-bucket-origin"
  description = "The unique identifier of Cloudfront S3 Bucket origin"
}

# variable "acm_certificate_arn" {
#   type        = string
#   default     = "arn:aws:acm:us-east-1:010663874085:certificate/39c0d094-616c-4b80-9f5f-47ecf7cbd9da"
#   description = "SSL certificate ARN from ACM"
# }
