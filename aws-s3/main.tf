terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.41.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}

resource "random_id" "rand_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "mys3bucket" {
  bucket = "mys3bucket-${random_id.rand_id.hex}"
}