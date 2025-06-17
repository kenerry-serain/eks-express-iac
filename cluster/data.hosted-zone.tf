data "aws_route53_zone" "this" {
  name         = var.custom_domain
}