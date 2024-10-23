resource "null_resource" "get-config" {
  depends_on = [aws_eks_node_group.dev-eks-public-nodegroup]
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --region us-east-1 --name ${aws_eks_cluster.dev-eks.name}"
  }
}

resource "helm_release" "external-dns" {
  depends_on = [null_resource.get-config]
  name       = "external-dns"
  repository = "https://kubernetes-sigs.github.io/external-dns/"
  chart      = "external-dns"
  namespace  = "external-ns"
  create_namespace = true

  set {
    name  = "policy"
    value = "sync"
  }

  set {
    name  = "serviceAccount.create"
    value = tobool("true")
  }

  set {
    name  = "serviceAccount.name"
    value = "name-dns"
  }

}

