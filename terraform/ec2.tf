# author zhenglisai
resource "aws_launch_template" "eks-template" {
  name = local.launch_template_name
  image_id = local.launch_template_image_id
  instance_type = local.launch_template_instance_type
  key_name = local.launch_template_key_name
  vpc_security_group_ids = [aws_security_group.eks-node.id]
  user_data = base64encode("#!/bin/bash\n/etc/eks/bootstrap.sh ${aws_eks_cluster.eks-cluster.name}")
}

