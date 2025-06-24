resource "aws_cloudwatch_log_group" "prometheus" {
  name = "/aws/prometheus/workspaces"
}

resource "aws_prometheus_workspace" "this" {
  alias = "eks-express-prometheus"
  logging_configuration {
    log_group_arn = "${aws_cloudwatch_log_group.prometheus.arn}:*"
  }
}
