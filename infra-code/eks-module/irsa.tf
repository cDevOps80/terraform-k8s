resource "aws_iam_openid_connect_provider" "oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
  url             = aws_eks_cluster.dev-eks.identity[0].oidc[0].issuer

  tags = {
      Name = "dev-eks-irsa"
  }
}

locals {
  oidc_provider_name_arn = aws_iam_openid_connect_provider.oidc_provider.arn
  oidc_provider_name_extract_arn = element(split("oidc-provider/", "${aws_iam_openid_connect_provider.oidc_provider.arn}"), 1)
}

resource "aws_iam_role" "eks-cluster-autoscale" {
  name = "eks-cluster-autoscale"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Principal" : {
          "Federated" : local.oidc_provider_name_arn
        },
        "Condition" : {
          "StringEquals" : {
            "${local.oidc_provider_name_extract_arn}:aud" : "sts.amazonaws.com",
            "${local.oidc_provider_name_extract_arn}:sub" : "system:serviceaccount:default:dev-sa",
            "${local.oidc_provider_name_extract_arn}:sub" : "system:serviceaccount:dev:dev-sa"
          }
        }
      }
    ]
  })

  tags = {
    Name = "eks-cluster-autoscale"
  }
}

resource "aws_iam_role_policy_attachment" "irsa_iam_role_policy_attach" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  role       = aws_iam_role.eks-cluster-autoscale.name
}
