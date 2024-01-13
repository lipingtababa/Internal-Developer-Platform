provider "aws" {
  region = "us-east-1"
}

resource "aws_secretsmanager_secret" "postgre" {
  name = "/watcher/postgre/password"
}

resource "aws_iam_policy" "secret_reader_policy" {
  name = "secret_reader_policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "secretsmanager:GetSecretValue"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_secretsmanager_secret.postgre.arn}"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_policy" "secret_writer_policy" {
  name = "secret_writer_policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "secretsmanager:PutSecretValue"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_secretsmanager_secret.postgre.arn}"
      ]
    }
  ]
}
EOF
}
