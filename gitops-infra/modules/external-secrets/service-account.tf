resource "kubernetes_service_account" "external_secrets_sa" {
  metadata {
    name      = var.secrets_sa_name
    namespace = var.app-namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = var.secrets_iam_role_arn
    }

  }

}
