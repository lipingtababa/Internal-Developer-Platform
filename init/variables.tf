provider "aws" {
  region = "us-east-1"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default = "us-east-1"
}

variable "aws_account" {
  description = "AWS account"
  type        = string
  default = "339713007259"
}
