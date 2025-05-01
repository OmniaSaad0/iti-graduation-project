resource "helm_release" "nginx" {
  name       = var.name
  namespace  = var.namespace
  repository = var.nginx_helm_repository
  chart      = var.nginx_helm_chart
  version    = var.ingress-version

  create_namespace = var.create_namespace

  values = [ file("${path.module}/${var.nginx_values}") ]
}
