# resource "kubernetes_secret" "github_credentials" {
#   metadata {
#     name      = "github-credentials"
#     namespace = "argocd"
#   }

#   type = "Opaque"

#   data = {
#     username = base64encode("ShehabGamal689")
#     password = base64encode(var.github_token)
#   }
# }

resource "kubernetes_secret" "github_credentials" {
  metadata {
    name      = "repo-github"  
    namespace = "argocd"
    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  type = "Opaque"

  data = {
    type     = base64encode("git")
    url      = base64encode("https://github.com/ShehabGamal689/gitops")
    username = base64encode("ShehabGamal689")
    password = base64encode(var.github_token)
  }
}
