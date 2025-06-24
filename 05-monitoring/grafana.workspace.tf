resource "aws_grafana_workspace" "this" {
  account_access_type      = "CURRENT_ACCOUNT"
  authentication_providers = ["AWS_SSO"]
  permission_type          = "SERVICE_MANAGED"
  role_arn                 = aws_iam_role.grafana.arn

  vpc_configuration {
    security_group_ids = [local.eks_cluster_security_group]
    subnet_ids         = data.aws_subnets.observability.ids
  }
}
