data "aws_vpc" "default" {
  default = true
}

resource "aws_eks_cluster" "idp" {
  name = "idp"
  role_arn = aws_iam_role.idp_node_role.arn
  vpc_config {
    subnet_ids = ["subnet-005a8db3663329ec9", "subnet-085f21f00fe245cda", "subnet-097c8eb90c15f52be"]
    security_group_ids = [aws_security_group.cluster_sg.id]
  }
}

resource "aws_security_group" "cluster_sg" {
  name = "cluster_sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    self        = true
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 31436
    to_port     = 31436
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_role" "idp_node_role" {
  name = "idp_node_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ec2.amazonaws.com", "eks.amazonaws.com"]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "idp_node_role_attach_ecr" {
  role       = aws_iam_role.idp_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "idp_node_role_attach_cni" {
  role       = aws_iam_role.idp_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "idp_node_role_attach_cluster" {
  role       = aws_iam_role.idp_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "idp_node_role_attach_node" {
  role       = aws_iam_role.idp_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_eks_addon" "eks_addon_cni" {
  cluster_name      = aws_eks_cluster.idp.name
  addon_name        = "vpc-cni"
  addon_version     = "v1.16.0-eksbuild.1"
}

resource "aws_eks_addon" "eks-addon-eks-pod-identity-agent" {
  cluster_name      = aws_eks_cluster.idp.name
  addon_name        = "eks-pod-identity-agent"
  addon_version     = "v1.0.0-eksbuild.1"
}

resource "aws_eks_addon" "eks_addon_proxy" {
  cluster_name      = aws_eks_cluster.idp.name
  addon_name        = "kube-proxy"
  addon_version     = "v1.28.4-eksbuild.4"
}

resource "aws_eks_addon" "eks_Xaddon_coredns" {
  cluster_name      = aws_eks_cluster.idp.name
  addon_name        = "coredns"
  addon_version     = "v1.10.1-eksbuild.6"
}

resource "aws_eks_node_group" "idp_node_group" {
  cluster_name    = aws_eks_cluster.idp.name
  node_group_name = "idp_node_group"
  node_role_arn   = aws_iam_role.idp_node_role.arn
  subnet_ids      = ["subnet-005a8db3663329ec9", "subnet-085f21f00fe245cda", "subnet-097c8eb90c15f52be"]
  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 0
  }
  instance_types  = ["t4g.2xlarge"]
  ami_type        = "AL2_ARM_64"
  remote_access {
    ec2_ssh_key = "machi"
    source_security_group_ids = [aws_security_group.cluster_sg.id]
  }
  depends_on = [aws_eks_addon.eks_addon_cni, aws_eks_addon.eks_addon_proxy]
}