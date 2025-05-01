variable "name" {
  default = "cert-manager"
}

variable "namespace" {
  default = "cert-manager"
}

variable "cert-version" {
  default = "v1.17.1"
}

variable "create_namespace" {
  default = true    
  
}

variable "force_update" {
  default = true
  
}

variable "replace" {
  default = true
  
}


variable "cert_values" {
  default = "cert-manager-values.yaml"
  
}

variable "cert_helm_chart" {
  default = "cert-manager"
}

variable "cert_helm_repository" {
  default = "https://charts.jetstack.io"
}
