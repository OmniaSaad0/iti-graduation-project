variable "jenkins_helm_chart" {
  description = "Jenkins Helm chart"
  type        = string
  default     = "jenkins"   
}

variable "jenkins_helm_repository" {
  description = "Jenkins Helm chart repository"
  type        = string
  default     = "https://charts.jenkins.io"
}

variable "jenkins_helm_name" {
  description = "Jenkins Helm chart name"
  type        = string
  default     = "jenkins"
}


variable "jenkins_helm_version" {
  description = "Jenkins Helm chart version"
  type        = string
  default     = "5.8.37"
}
variable "jenkins_helm_namespace" {
  description = "Jenkins Helm chart namespace"
  type        = string
  default     = "jenkins"
}


variable "jenkins_helm_create_namespace" {
  description = "Create namespace for Jenkins Helm chart"
  type        = bool
  default     = true
}


variable "jenkins_helm_values" {
  description = "Values for Jenkins Helm chart"
  type        = string
  default     = "jenkins-values.yaml"
}

# ===========================================================


variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-1"
  
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "my-eks"
  
}

variable "eks_pod_identity_ecr_role" {
  description = "EKS Pod Identity ECR role"
  type        = string
}

variable "ecr_full_access_sa_name" {
  description = "ECR full access service account name"
  type        = string
  default     = "ecr-access-sa"
  
}

variable "ebs_csi_role_arn" {
  description = "EBS CSI role ARN"
  type        = string
  
}