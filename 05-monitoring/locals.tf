locals {
  eks_cluster_arn            = data.terraform_remote_state.cluster_stack.outputs.eks_cluster_arn
  eks_cluster_name           = data.terraform_remote_state.cluster_stack.outputs.eks_cluster_name
  eks_cluster_security_group = data.terraform_remote_state.cluster_stack.outputs.eks_cluster_security_group
}
