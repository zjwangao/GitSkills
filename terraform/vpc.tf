# author zhenglisai
resource "aws_vpc" "eks" {
  cidr_block = local.vpc_cidr_block
  enable_dns_hostnames = "true"
  tags = {
    Name = "eks"
  }
}

# 定义Subnet子网
resource "aws_subnet" "subnet_1" {
  vpc_id = aws_vpc.eks.id
  map_public_ip_on_launch = true
  cidr_block = local.subnet_1_cidr_block
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "subnet_1"
    "kubernetes.io/role/elb" = "1"
  }
}
resource "aws_subnet" "subnet_2" {
  vpc_id = aws_vpc.eks.id
  map_public_ip_on_launch = true
  cidr_block = local.subnet_2_cidr_block
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "subnet_2"
    "kubernetes.io/role/elb" = "1"
  }
}
# 创建公网接口
resource "aws_internet_gateway" "igw-eks" {
  vpc_id = aws_vpc.eks.id
  tags = {
    Name = "igw-eks"
  }
}
# 修改路由表
data "aws_route_table" "route_table_eks" {
  vpc_id = aws_vpc.eks.id
  filter {
    name = "association.main"
    values = [true]
  }
}
resource "aws_route" "route_table_eks" {
  route_table_id = data.aws_route_table.route_table_eks.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw-eks.id
}

