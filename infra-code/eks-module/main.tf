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
    service_ipv4_cidr = "10.0.0.0/16"
  }
}

# public-node

resource "aws_eks_node_group" "dev-eks-public-nodegroup" {
  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
  ]
  cluster_name    = aws_eks_cluster.dev-eks.name
  node_group_name = "dev-eks-public-nodegroup"
  node_role_arn   = aws_iam_role.node_role.arn
  subnet_ids      = var.public_subnets
  capacity_type   = "SPOT"
  instance_types  = ["t3.small"]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  remote_access {
    ec2_ssh_key = "nvirginia"
  }

  tags = {
    Name = "dev-eks-public-nodegroup"
  }
}

# private-node
resource "aws_eks_node_group" "dev-eks-private-nodegroup" {
  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
  ]
  cluster_name    = aws_eks_cluster.dev-eks.name
  node_group_name = "dev-eks-public-nodegroup"
  node_role_arn   = aws_iam_role.node_role.arn
  subnet_ids      = var.private_subnets
  capacity_type   = "SPOT"
  instance_types  = ["t3.small"]

  update_config {
    max_unavailable = 1
  }

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  remote_access {
    ec2_ssh_key = "nvirginia"
  }

  tags = {
    Name = "dev-eks-private-nodegroup"
  }

}
