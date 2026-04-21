terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.41.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}
resource "aws_s3_bucket" "mys3bucket" {
  bucket = "mys3bucket123"
}