resource "aws_iam_role" "watcher_pod_role" {
  name = "watcher"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Principal": {
        "Service": "pods.eks.amazonaws.com"
      },
      "Action": [
                "sts:AssumeRole",
                "sts:TagSession"
            ],
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "watcher_pod_role_read_secret" {
  role       = aws_iam_role.watcher_pod_role.name
  policy_arn = aws_iam_policy.secret_reader_policy.arn
}

resource "aws_iam_role_policy_attachment" "watcher_pod_role_access_s3" {
  role       = aws_iam_role.watcher_pod_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_role_policy_attachment" "watcher_pod_role_pull_image" {
  role       = aws_iam_role.watcher_pod_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}