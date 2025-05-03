resource "kubernetes_secret" "github_credentials" {
  metadata {
    name      = "github-credentials"
    namespace = "argocd"
    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  type = "Opaque"

  data = {
    type           = base64encode("git")
    url            = base64encode("git@github.com:ShehabGamal689/gitops.git")
    sshPrivateKey  = base64encode(file("~/.ssh/yes")) # Or use a variable if preferred
  }
}
