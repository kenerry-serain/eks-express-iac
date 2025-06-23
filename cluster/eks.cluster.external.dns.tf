resource "helm_release" "external_dns" {
  name             = "external-dns"
  repository       = "https://kubernetes-sigs.github.io/external-dns/"
  chart            = "external-dns"
  version          = "1.16.1"
  namespace        = "external-dns"
  create_namespace = true

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.external_dns.arn
  }

  depends_on = [
    aws_iam_role_policy_attachment.external_dns,
    aws_eks_node_group.this,
    aws_eks_access_policy_association.bash_user,
  ]
}
