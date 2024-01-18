provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "lipingtababa-tf-statefiles"
    key    = "shared/eks-cluster/terraform.tfstate"
    region = "us-east-1"
  }
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

variable "stage" {
  description = "Stage"
  type        = string
  default = "dev"
}
