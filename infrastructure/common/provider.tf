provider "aws" {
  profile = "default"
  region  = "us-east-1" # Lambda@Edge supports only us-east-1 region!
}
