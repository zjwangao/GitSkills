# author zhenglisai
# 集群
resource "aws_eks_cluster" "eks-cluster" {
  name     = local.cluster_name
  role_arn = aws_iam_role.eks-cluster.arn
  vpc_config {
    subnet_ids = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
    security_group_ids = [aws_security_group.eks-cluster.id]
  }
}
# 计算节点
resource "aws_eks_node_group" "eks-node" {
  cluster_name  = aws_eks_cluster.eks-cluster.name
  node_group_name = local.node_name
  node_role_arn = aws_iam_role.eks-node.arn
  subnet_ids    = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
  launch_template {
    version = aws_launch_template.eks-template.latest_version
    id = aws_launch_template.eks-template.id
  }
}

