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


variable "instance_type" {
  description = "Instance type for EC2"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
}

variable "key_name" {
  description = "EC2 SSH key name"
  type        = string
}
