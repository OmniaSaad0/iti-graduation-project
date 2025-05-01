variable "vpc_cidr" {
  type = string
  description = "CIDR block for the VPC"
}

variable "region" {
  type = string
  description = "AWS region to deploy the VPC"
}

variable "private_subnets" {
  type = list(string)
  description = "List of CIDR blocks for private subnets"
}

variable "public_subnets" {
  type = list(string)
  description = "List of CIDR blocks for public subnets"
}

