resource "aws_eks_cluster" "dev-eks" {

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]
  name     = "dev-eks"
  role_arn = aws_iam_role.cluster_role.arn

  vpc_config {
    subnet_ids = var.public_subnets
    endpoint_public_access = true
  }

  kubernetes_network_config {
    service_ipv4_cidr = "192.168.0.0/16"
  }
}

resource "aws_eks_addon" "eks-pod-identity-agent" {
  cluster_name                = aws_eks_cluster.dev-eks.name
  addon_name                  = "eks-pod-identity-agent"
  addon_version               = "v1.3.2-eksbuild.2"
  resolve_conflicts_on_update = "OVERWRITE"
  resolve_conflicts_on_create = "OVERWRITE"
}

# code for fargate-profiles
resource "aws_eks_fargate_profile" "kube-system" {
  cluster_name           = aws_eks_cluster.dev-eks.name
  fargate_profile_name   = "kube-system"
  pod_execution_role_arn = aws_iam_role.fargate_role.arn
  subnet_ids             = var.private_subnets

  selector {
    namespace = "kube-system"
  }
}

// TO create fargate-profile for another namespace
resource "null_resource" "kube-config" {
 // depends_on = [aws_eks_cluster.dev-eks]
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --region us-east-1 --name ${aws_eks_cluster.dev-eks.name}"
  }
}

#resource "kubernetes_namespace" "example" {
#  metadata {
#    name = "dev-ns"
#  }
#}

resource "aws_eks_fargate_profile" "dev-ns" {
  cluster_name           = aws_eks_cluster.dev-eks.name
  fargate_profile_name   = "dev-ns"
  pod_execution_role_arn = aws_iam_role.fargate_role.arn
  subnet_ids             = var.private_subnets

  selector {
    namespace = "dev-ns"
    labels = {
      app = "chaitu1"
    }
  }
}