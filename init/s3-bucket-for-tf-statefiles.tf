
resource "aws_s3_bucket" "lipingtababa_tf_statefiles" {
  bucket = "lipingtababa-tf-statefiles"
}

resource "aws_s3_bucket_versioning" "lipingtababa_tf_statefiles_versioning" {
  bucket = aws_s3_bucket.lipingtababa_tf_statefiles.bucket
  versioning_configuration {
    status = "Enabled"
  }
}
