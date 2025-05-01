resource "helm_release" "jenkins" {

  name = var.jenkins_helm_name
  repository = var.jenkins_helm_repository
  chart = var.jenkins_helm_chart
  namespace = var.jenkins_helm_namespace
  create_namespace = var.jenkins_helm_create_namespace
  version = var.jenkins_helm_version

  values = [file("${path.module}/${var.jenkins_helm_values}")]
  
  depends_on = [ helm_release.ebs_csi ]
}

