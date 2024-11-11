resource "helm_release" "external-secrets" {
  depends_on = [null_resource.kubectl-config]

  name              = "external-secrets"
  repository        = "https://charts.external-secrets.io"
  chart             = "external-secrets"
  namespace         = "external-secrets"
  create_namespace  = true
}

resource "null_resource" "css" {
  triggers = {
    time = var.trigger
  }
  provisioner "local-exec" {
    command = <<EOT
kubectl apply -f "${path.module}"/css.yaml
EOT
  }
}

variable "trigger" {
  name = "change1"
}