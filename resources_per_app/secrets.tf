resource "aws_secretsmanager_secret" "db_password" {
  name = "/${var.app_name}/${var.stage}/db-password"
}

resource "random_password" "password" {
  length  = 16
  special = true
  override_special = "_-#%"
}

resource "aws_secretsmanager_secret_version" "db_password_version" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = random_password.password.result
}

resource "aws_iam_policy" "secret_reader_policy" {
  name = "${var.app_name}_${var.stage}_secret_reader_policy"
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
