resource "aws_instance" "bastion" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = module.network.public_subnet1
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  key_name               = var.key_name
  associate_public_ip_address = true
  iam_instance_profile   = aws_iam_instance_profile.eks_bastion_instance_profile.name

  tags = {
    Name = "bastion"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> EC2_IPs.txt"
  }
}

resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH from trusted IP and access to EKS"
  vpc_id      = module.network.my_vpc

  # Allow SSH into bastion
  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sg"
  }
}


# Create the IAM Role for the EC2 Bastion
resource "aws_iam_role" "eks_bastion_role" {
  name = "eks-bastion-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# # Create an IAM Policy for EKS Permissions
resource "aws_iam_policy" "eks_bastion_policy" {
  name        = "eks-bastion-policy"
  description = "Policy to allow interaction with EKS and related EC2 resources"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # EKS Permissions
      {
        Effect   = "Allow"
        Action   = [
          "eks:DescribeCluster",
          "eks:ListClusters",
          "eks:DescribeNodegroup",
          "eks:ListNodegroups",
          "eks:UpdateClusterConfig",
          "eks:UpdateClusterVersion",
          "eks:DescribeClusterVersions",  
          "eks:CreateCluster",            
          "eks:DeleteCluster",            
          "eks:ListUpdates",              
          "eks:DescribeUpdate",           
          "eks:DescribeFargateProfile",   
          "eks:ListFargateProfiles",
          "eks:AccessKubernetesApi"
      
        ]
        Resource = "*"
      },
      # EC2 Permissions
      {
        Effect   = "Allow"
        Action   = [
          "ec2:DescribeInstances",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcs",
          "ec2:DescribeRegions",
          "ec2:DescribeKeyPairs",
          "ec2:DescribeInternetGateways",
          "ec2:DescribeRouteTables"
        ]
        Resource = "*"
      }
    ]
  })
}



# Attach the Policy to the IAM Role
resource "aws_iam_role_policy_attachment" "eks_bastion_policy_attachment" {
  role       = aws_iam_role.eks_bastion_role.name
  policy_arn = aws_iam_policy.eks_bastion_policy.arn
}
# Attach the IAM Role to the EC2 Instance
resource "aws_iam_instance_profile" "eks_bastion_instance_profile" {
  name = "eks-bastion-instance-profile"
  role = aws_iam_role.eks_bastion_role.name
}