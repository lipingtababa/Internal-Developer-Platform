resource "aws_secretsmanager_secret" "db_password" {
  name = "/${var.app_name}/${var.stage}/db-password"
}

resource "random_password" "password" {
  length  = 16
  special = true
}

resource "aws_secretsmanager_secret_version" "db_password_version" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = random_password.password.result
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
        "arn:aws:secretsmanager:${var.aws_region}:${var.aws_account}:secret:/${var.app_name}/${var.stage}/*"
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
        "arn:aws:secretsmanager:${var.aws_region}:${var.aws_account}:secret:/${var.app_name}/${var.stage}/*"
      ]
    }
  ]
}
EOF
}
