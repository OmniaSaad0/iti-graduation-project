resource "kubernetes_service_account" "ecr_access_sa" {
  metadata {
    name      = var.ecr_full_access_sa_name
    namespace = var.jenkins_helm_namespace

    annotations = {
      "eks.amazonaws.com/role-arn" = var.eks_pod_identity_ecr_role
    }
  }

  depends_on = [ helm_release.jenkins ]
}


resource "aws_eks_pod_identity_association" "ecr_access_association" {
  cluster_name    = var.cluster_name
  namespace       = kubernetes_service_account.ecr_access_sa.metadata[0].namespace
  service_account = kubernetes_service_account.ecr_access_sa.metadata[0].name
  role_arn        = var.eks_pod_identity_ecr_role
}
