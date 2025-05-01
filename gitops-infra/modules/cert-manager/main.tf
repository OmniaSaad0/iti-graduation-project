resource "helm_release" "cert_manager" {
    name = var.name

    repository       = var.cert_helm_repository
    chart            = var.cert_helm_chart
    namespace        = var.namespace
    create_namespace = var.create_namespace
    version          = var.cert-version
    force_update     = var.force_update
    replace          = var.replace

    values           = [file("${path.module}/${var.cert_values}")]

}