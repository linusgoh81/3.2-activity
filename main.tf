provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  required_version = "~> 1.0" # Or your preferred version constraint

  backend "s3" {
    bucket = "sctp-ce8-tfstate"
    key    = "linus-s3-tf-ci.tfstate" #Change this
    region = "ap-southeast-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Or your preferred version constraint
    }
  }
}

data "aws_caller_identity" "current" {}

locals {
  name_prefix = split("/", data.aws_caller_identity.current.arn)[1]
  account_id  = data.aws_caller_identity.current.account_id
}

resource "aws_s3_bucket" "s3_tf" {
  #checkov:skip=CKV2_AWS_61:The bucket is a public static content host
  #checkov:skip=CKV_AWS_145:The bucket is a public static content host
  #checkov:skip=CKV_AWS_144:The bucket is a public static content host
  #checkov:skip=CKV_AWS_18:The bucket is a public static content host
  #checkov:skip=CKV2_AWS_6:The bucket is a public static content host
  #checkov:skip=CKV_AWS_21:The bucket is a public static content host
  #checkov:skip=CKV2_AWS_62:The bucket is a public static content host
  bucket = "${local.name_prefix}-s3-tf-bkt-${local.account_id}"
}

