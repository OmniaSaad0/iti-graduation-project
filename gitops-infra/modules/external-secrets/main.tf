
resource "helm_release" "external_secrets" {
    name             = var.external_secrets_name
    namespace        = var.external_secrets_namespace
    repository       = var.external_secrets_repo
    chart            = var.external_secrets_chart
    version          = var.external_secrets_version
    create_namespace = var.create_namespace

  set {
    name  = "serviceAccount.create"
    value = var.create_secrets_sa
  }

  set {
    name  = "serviceAccount.name"
    value = var.secrets_sa_name
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = var.secrets_iam_role_arn
  }
   
}
