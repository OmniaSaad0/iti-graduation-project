module "jenkins" {
  source = "./modules/jenkins"
  ebs_csi_role_arn = data.aws_iam_role.ebs_csi.arn
  eks_pod_identity_ecr_role = data.aws_iam_role.eks_pod_identity_ecr.arn
}

module "external_secrets" {
  source = "./modules/external-secrets"
  secrets_iam_role_arn = data.aws_iam_role.external_secrets_irsa.arn
}

module "argocd" {
  source = "./modules/argocd"
  ecr_read_access_role_arn = data.aws_iam_role.argocd_ecr_role.arn
  depends_on = [ module.cert-manager, module.nginx ]
}

module "nginx" {
  source = "./modules/nginx"
}

module "cert-manager" {
  source = "./modules/cert-manager"
}