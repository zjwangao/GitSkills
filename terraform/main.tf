# author zhangjiao
# 使用当前脚本所在服务器角色权限
provider "aws" {
  region = "ap-northeast-1"
}
# 获取当前可用区
data "aws_availability_zones" "available" {
  state = "available"
}
# 本地参数，下面参数均可根据自己需要修改。
locals {
  # EKS集群名
  cluster_name = "tf-cluster-sophie"
  # EKS集群角色名
  cluster_role_name = "tf-cluster-rolesophie"
  # EKS计算节点名
  node_name = "tf-node-sophie"
  # EKS计算节点角色
  node_role_name = "tf-node-rolesophie"
  # EKS计算节点使用的启动模板名
  launch_template_name = "tf-cluster-template-sophie"
  # image_id每个区域不同，此ID仅适用于us-west-2区域，其他区域的镜像请参见AWS文档
  launch_template_image_id = "ami-03350e4f182961c7f"
  # EKS计算节点使用的实例类型
  launch_template_instance_type = "t2.micro"
  # 服务器登录密钥，需要提前在EC2的密钥管理中配置好
  launch_template_key_name = "tfkey"
  # EKS集群使用的VPC网段
  vpc_cidr_block = "10.2.0.0/16"
  # EKS集群使用的子网网段
  subnet_1_cidr_block = "10.2.0.0/20"
  # EKS集群使用的子网网段
  subnet_2_cidr_block = "10.2.16.0/20"
}

