data "aws_eks_cluster" "main" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "main" {
  name = var.cluster_name

}

data "aws_iam_role" "ebs_csi" { 
  name = "eks-ebs-csi-driver" 
}


data "aws_iam_role" "eks_pod_identity_ecr" {
  name = "eks-pod-ecr-role" 
}

data "aws_iam_role" "external_secrets_irsa" {
  name = "external-secrets-irsa"
}

data "aws_iam_role" "argocd_ecr_role" {
  name = "argocd-ecr-role"
}


