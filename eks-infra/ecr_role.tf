resource "aws_iam_role" "eks_pod_identity_ecr" {
  name = "eks-pod-ecr-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
        Action = [
            "sts:AssumeRole",
            "sts:TagSession"
        ]
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "ecr_full_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  role       = aws_iam_role.eks_pod_identity_ecr.name
}

# ======================================================================

# resource "aws_iam_policy" "ecr_readonly" {
#   name        = "ECRReadOnlyForArgoCD"
#   description = "Policy to allow Argo CD to pull images from ECR"
#   policy      = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect   = "Allow",
#       Action   = [
#         "ecr:GetAuthorizationToken",
#         "ecr:BatchCheckLayerAvailability",
#         "ecr:GetDownloadUrlForLayer",
#         "ecr:BatchGetImage"
#       ],
#       Resource = "*"
#     }]
#   })
# }

resource "aws_iam_role" "argocd_ecr_role" {
  name = "argocd-ecr-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Federated =  aws_iam_openid_connect_provider.eks.arn
      },
      Action = "sts:AssumeRoleWithWebIdentity",
      Condition = {
        StringEquals = {
          "${replace(data.aws_eks_cluster.main.identity[0].oidc[0].issuer, "https://", "")}:sub" = "system:serviceaccount:argocd:ecr-read-access-sa"
        }
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_ecr_policy" {
  role       = aws_iam_role.argocd_ecr_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
