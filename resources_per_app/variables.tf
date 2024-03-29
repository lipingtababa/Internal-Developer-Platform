provider "aws" {
  region = "us-east-1"
}

variable "app_name" {
  description = "Name of the application"
  type        = string
}

variable "stage" {
  description = "Stage of the application"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "aws_account" {
  description = "AWS account"
  type        = string
}

terraform {
  backend "s3" {
    bucket = "lipingtababa-tf-statefiles"
    key    = "app/terraform.tfstate"
    region = "us-east-1"
  }
}
