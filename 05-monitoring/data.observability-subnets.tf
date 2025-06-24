data "aws_subnets" "observability" {
  filter {
    name   = "tag:Project"
    values = ["eks-express"]
  }

  filter {
    name   = "tag:Purpose"
    values = ["observability"]
  }
}
