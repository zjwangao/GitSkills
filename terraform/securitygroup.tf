# author zhenglisai
resource "aws_security_group" "eks-cluster" {
  name        = "eks-cluster"
  description = "Allow local vpc"
  vpc_id      = aws_vpc.eks.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [local.vpc_cidr_block]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "eks-cluster"
  }
}
resource "aws_security_group" "eks-node" {
  name        = "eks-node"
  description = "Allow local vpc"
  vpc_id      = aws_vpc.eks.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [local.vpc_cidr_block]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "eks-node"
  }
}

