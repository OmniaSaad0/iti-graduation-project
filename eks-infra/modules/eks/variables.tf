variable "cluster_name" {}
variable "cluster_version" {
  default = "1.29"
}

variable "vpc_id" {}
variable "private_subnet_ids" {
  type = list(string)
}

variable "node_instance_type" {
  default = "t2.medium"
}

variable "node_group_desired_size" {
  default = 2
}
variable "node_group_min_size" {
  default = 1
}
variable "node_group_max_size" {
  default = 3
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "bastion_sg_id" {
  description = "Security group ID for the bastion host"
  type        = string
  
}