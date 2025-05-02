resource "kubernetes_namespace" "argocd-ns" {
  metadata {
    name = "argocd"
  }
}


resource "helm_release" "argocd" {
  name       = var.argocd_helm_name
  namespace  = var.argocd_helm_namespace
  repository = var.argocd_helm_repository
  chart      = var.argocd_helm_chart
  version = "7.3.11"

  create_namespace = false

  values = [file("${path.module}/${var.argocd_values}")]
  depends_on = [ kubernetes_service_account.ecr_read_access ]
  

}


resource "helm_release" "argo_image_updater" {
  name = var.argo_image_updater_helm_name
  namespace = var.argocd_helm_namespace
  repository = var.argo_image_updater_helm_repository
  chart = var.argo_image_updater_helm_chart
  version = "0.11.0"
  
  create_namespace = false

  values = [file("${path.module}/${var.argo_image_updater_values}")]
  depends_on = [helm_release.argocd]
} 
 


