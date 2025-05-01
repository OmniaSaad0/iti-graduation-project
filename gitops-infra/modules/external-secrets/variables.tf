variable "external_secrets_name" {
  default = "external-secrets"
}

variable "external_secrets_namespace" {
  default = "external-secrets"
}

variable "external_secrets_repo" {
  default = "https://charts.external-secrets.io"
}

variable "external_secrets_chart" {
  default = "external-secrets"
}

variable "external_secrets_version" {
  default = "0.9.10"
}


variable "create_namespace" {
  description = "Create namespace for external secrets"
  type        = bool
  default     = true
  
}

variable "secrets_sa_name" {
  default = "external-secrets-sa"
}

variable "create_secrets_sa" {
  description = "Create service account for external secrets"
  type        = bool
  default     = true
  
}

variable "secrets_iam_role_arn" {
  description = "IAM role ARN for external secrets"
  type        = string
}


variable "app-namespace" {
    description = "Namespace for the application"
    type        = string
    default     = "default" 
}