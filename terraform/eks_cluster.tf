resource "aws_eks_cluster" "eks_cluster" {
  name     = "my-eks-cluster-for-project-1"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.30"

  vpc_config {
    subnet_ids = [
      aws_subnet.public_subnet.id,
      aws_subnet.private_subnet.id,
    ]
    endpoint_public_access  = true
    endpoint_private_access = false
  }
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy_attachment,
    aws_iam_role_policy_attachment.eks_service_policy_attachment,
  ]
}

output "cluster_name" {
  value       = aws_eks_cluster.eks_cluster.name
  description = "The name of the EKS cluster."
}
output "cluster_endpoint" {
  value       = aws_eks_cluster.eks_cluster.endpoint
  description = "The endpoint for the EKS cluster."
}

terraform {
  backend "s3" {
    bucket = "my-bucket-for-final-project-1"
    key    = "project_1/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true 
    encrypt = true
  }
}
