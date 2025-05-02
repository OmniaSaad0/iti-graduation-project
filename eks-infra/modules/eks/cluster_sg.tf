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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group_rule" "allow_bastion_to_nodes" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_cluster_sg.id
  # source_security_group_id = aws_security_group.bastion_sg.id
  source_security_group_id = var.bastion_sg_id
  description              = "Allow EKS API access from bastion"
}

resource "aws_security_group_rule" "allow_bastion_cluster" {
  type                     = "ingress"
  from_port                = 33080
  to_port                  = 33080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_cluster_sg.id
  # source_security_group_id = aws_security_group.bastion_sg.id
  source_security_group_id = var.bastion_sg_id
  description              = "Allow EKS API access from bastion"
}

