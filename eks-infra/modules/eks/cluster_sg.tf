resource "aws_security_group" "eks_cluster_sg" {
  name   = "eks-cluster-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow nodes to communicate with control plane"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.worker_group_sg.id]
  }
  ingress  {
    description = "Allow bastian to communicate with control plane"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [var.bastion_sg_id]
  }
  ingress {
    description = "Allow bastian to communicate with control plane"
    from_port   = 33080
    to_port     = 33080
    protocol    = "tcp"
    security_groups = [var.bastion_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



