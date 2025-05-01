resource "kubernetes_service_account" "ecr_read_access" {
  metadata {
    name      = var.ecr_read_access_sa_name
    namespace = var.argocd_helm_namespace

    annotations = {
      "eks.amazonaws.com/role-arn" = var.ecr_read_access_role_arn
    }
  }

}
