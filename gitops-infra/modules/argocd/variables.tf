variable "argocd_values" {
  description = "Values for ArgoCD Helm chart"
  type        = string
  default     = "argocd-values.yaml"
  
}

                                
variable "argocd_helm_chart" {
  description = "ArgoCD Helm chart"
  type        = string
  default     = "argo-cd"
}

variable "argocd_helm_repository" {
  description = "ArgoCD Helm chart repository"
  type        = string
  default     = "https://argoproj.github.io/argo-helm"
}

variable "argocd_helm_name" {
  description = "ArgoCD Helm chart name"
  type        = string
  default     = "argocd"
}

variable "argocd_helm_version" {
  description = "ArgoCD Helm chart version"
  type        = string
  default     = "5.41.0"
}                                   
variable "argocd_helm_namespace" {
  description = "ArgoCD Helm chart namespace"
  type        = string              
    default     = "argocd"
}


variable "argocd_helm_create_namespace" {
  description = "Create namespace for ArgoCD Helm chart"
  type        = bool
  default     = true
}



# ==========================================================

variable "argo_image_updater_values" {
  description = "Values for ArgoCD Image Updater Helm chart"
  type        = string
  default     = "argo-image-updater-values.yaml"
}       


variable "argo_image_updater_helm_chart" {
  description = "ArgoCD Image Updater Helm chart"
  type        = string
  default     = "argocd-image-updater"
}


variable "argo_image_updater_helm_repository" {
  description = "ArgoCD Image Updater Helm chart repository"
  type        = string
  default     = "https://argoproj.github.io/argo-helm"
}

variable "argo_image_updater_helm_name" {
  description = "ArgoCD Image Updater Helm chart name"
  type        = string
  default     = "argo-image-updater"
}


# ===========================================================

variable "ecr_read_access_sa_name" {
  description = "ECR read access service account name"
  type        = string
  default     = "ecr-read-access-sa"
  
}

variable "ecr_read_access_role_arn" {
  description = "ECR read access IAM role arn"
  type        = string  
}

# ===========================================================

variable "github_token" {
  description = "GitHub token for ArgoCD"
  type        = string
  
}


#b9NSbLWOG9ojj7eD