resource "aws_prometheus_scraper" "this" {
  source {
    eks {
      cluster_arn = local.eks_cluster_arn
      subnet_ids  = data.aws_subnets.observability.ids
    }
  }

  destination {
    amp {
      workspace_arn = aws_prometheus_workspace.this.arn
    }
  }

  scrape_configuration = file("${path.module}/prometheus/scrape-config.yml")
}
