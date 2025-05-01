variable "region1" {
  type = string
}

variable "region" {
  default = "us-east-1"
}

variable "cluster_name" {
  type = string
  default = "my-eks"
  
}