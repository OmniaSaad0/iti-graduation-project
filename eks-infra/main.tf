provider "aws" {
  region = var.region1
}

module "network" {
  source         = "./modules/network"
  region         = var.region1
  vpc_cidr       = "10.0.0.0/16"
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

}

module "eks" {
  source = "./modules/eks"

  cluster_name          = var.cluster_name
  cluster_version       = "1.29"
  vpc_id                = module.network.my_vpc
  private_subnet_ids    = [module.network.private_subnet1, module.network.private_subnet2, module.network.private_subnet3]

  node_instance_type       = "t3.large"
  node_group_desired_size  = 3
  node_group_min_size      = 1
  node_group_max_size      = 3
  bastion_sg_id = aws_security_group.bastion_sg.id


  tags = {
    Environment = "dev"
    Project     = "eks-from-scratch"
  }
}
