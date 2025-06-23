output "kubernetes_oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.kubernetes.arn
}

output "kubernetes_oidc_provider_url" {
  value = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

output "eks_cluster_name" {
  value = aws_eks_cluster.this.name
}

output "eks_cluster_security_group" {
  value = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}