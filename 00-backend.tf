# Note: The bucket name may not work for you since buckets are unique globally in AWS, so you must give it a unique name.
//resource "aws_s3_bucket" "terraform_state" {
//  bucket = "containarr"
//  # Enable versioning so we can see the full revision history of our state files
//  versioning {
//    enabled = true
//  }
//  # Enable server-side encryption by default
//  server_side_encryption_configuration {
//    rule {
//      apply_server_side_encryption_by_default {
//        sse_algorithm = "AES256"
//      }
//    }
//  }
//}
//
//resource "aws_dynamodb_table" "terraform_locks" {
//  name         = "terraform-locks"
//  billing_mode = "PAY_PER_REQUEST"
//  hash_key     = "LockID"
//  attribute {
//    name = "LockID"
//    type = "S"
//  }
//}

terraform {
  required_version = ">= 1.2.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
  backend "s3" {
    bucket  = "containar"
    key     = "global/s3/terraform.tfstate"
    encrypt = true
    region  = "us-east-1"
    profile = "devops.chisom"
  }
}
