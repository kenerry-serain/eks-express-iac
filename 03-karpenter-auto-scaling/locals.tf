locals {
  karpenter_node_role_name               = data.terraform_remote_state.cluster_stack.outputs.karpenter_node_role_name
  eks_cluster_node_group_name            = data.terraform_remote_state.cluster_stack.outputs.eks_cluster_node_group_name
  eks_cluster_certificate_authority_data = data.terraform_remote_state.cluster_stack.outputs.eks_cluster_certificate_authority_data
  eks_cluster_endpoint                   = data.terraform_remote_state.cluster_stack.outputs.eks_cluster_endpoint
  eks_cluster_security_group             = data.terraform_remote_state.cluster_stack.outputs.eks_cluster_security_group
  eks_cluster_name                       = data.terraform_remote_state.cluster_stack.outputs.eks_cluster_name
  eks_oidc_arn                           = data.terraform_remote_state.cluster_stack.outputs.kubernetes_oidc_provider_arn
  eks_oidc_url                           = replace(data.terraform_remote_state.cluster_stack.outputs.kubernetes_oidc_provider_url, "https://", "")
}
