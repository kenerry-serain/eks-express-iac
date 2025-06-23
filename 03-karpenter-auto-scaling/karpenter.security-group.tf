resource "aws_ec2_tag" "cluster_security_group" {
  resource_id = local.eks_cluster_security_group
  key         = "karpenter.sh/discovery"
  value       = local.eks_cluster_name
}
