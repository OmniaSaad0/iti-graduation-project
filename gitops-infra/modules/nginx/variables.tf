variable "name" {
  default = "ingress-nginx"
}

variable "namespace" {
  default = "ingress-nginx"
}

variable "ingress-version" {
  default = "4.12.1"
}

variable "service_type" {
  default = "LoadBalancer"
}


variable "create_namespace" {
  default = true    
  
}

variable "nginx_values" {
  default = "nginx-values.yaml"
  
}

variable "nginx_helm_chart" {
  default = "ingress-nginx"
}

variable "nginx_helm_repository" {
  default = "https://kubernetes.github.io/ingress-nginx"
}
