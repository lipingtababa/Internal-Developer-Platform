provider "aws" {
  region = "us-east-1"
}

variable "app_name" {
  description = "Name of the application"
  type        = string
  default     = "watcher"
}

variable "stage" {
  description = "Stage of the application"
  type        = string
  default     = "production"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "aws_account" {
  description = "AWS account"
  type        = string
  default     = "339713007259"
}
