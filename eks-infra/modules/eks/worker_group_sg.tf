 
resource "aws_security_group" "worker_group_sg" {
  name   = "eks-worker-sg"
  vpc_id = var.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group_rule" "node-ingress-self" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  security_group_id = aws_security_group.worker_group_sg.id
  source_security_group_id = aws_security_group.worker_group_sg.id
  
}




resource "aws_security_group_rule" "node-ingress-control" {
  type              = "ingress"
  from_port         = 1025
  to_port           = 65535
  protocol          = "tcp"
  security_group_id = aws_security_group.worker_group_sg.id
  source_security_group_id = aws_security_group.eks_cluster_sg.id
  
}



