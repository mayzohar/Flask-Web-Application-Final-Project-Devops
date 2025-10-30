resource "aws_iam_role" "eks_nodegroup_role" {
  name = "eks-nodegroup-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_nodegroup_policy_attachment_1" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodegroup_role.name
}

resource "aws_iam_role_policy_attachment" "eks_nodegroup_policy_attachment_2" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodegroup_role.name
}

resource "aws_iam_role_policy_attachment" "eks_nodegroup_policy_attachment_3" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodegroup_role.name
}

resource "aws_eks_node_group" "eks_nodegroup_1" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "ng-public-a"
  node_role_arn   = aws_iam_role.eks_nodegroup_role.arn
  subnet_ids      = [aws_subnet.public_subnet.id]
  instance_types  = ["t3a.small"]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_nodegroup_policy_attachment_1,
    aws_iam_role_policy_attachment.eks_nodegroup_policy_attachment_2,
    aws_iam_role_policy_attachment.eks_nodegroup_policy_attachment_3,
  ]
}

resource "aws_eks_node_group" "eks_nodegroup_2" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "ng-private-b"
  node_role_arn   = aws_iam_role.eks_nodegroup_role.arn
  subnet_ids      = [aws_subnet.private_subnet.id]
  instance_types  = ["t3a.small"]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_nodegroup_policy_attachment_1,
    aws_iam_role_policy_attachment.eks_nodegroup_policy_attachment_2,
    aws_iam_role_policy_attachment.eks_nodegroup_policy_attachment_3,
  ]
}



