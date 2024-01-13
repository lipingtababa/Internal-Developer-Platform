resource "aws_iam_role" "github_action_role" {
  name = "github-action"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Principal": {
        "Federated": "arn:aws:iam::339713007259:oidc-provider/token.actions.githubusercontent.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
        },
        "StringLike": {
          "token.actions.githubusercontent.com:sub": "repo:lipingtababa/*"
        }
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "github_action_role_write_secrets" {
  role       = aws_iam_role.github_action_role.name
  policy_arn = aws_iam_policy.secret_writer_policy.arn
}

resource "aws_iam_role_policy_attachment" "github_action_role_push_ecr" {
  role       = aws_iam_role.github_action_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}