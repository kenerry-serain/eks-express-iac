resource "aws_wafv2_web_acl" "this" {
  name  = var.waf.name
  scope = var.waf.scope

  default_action {
    allow {}
  }

  rule {
    name     = "00-CountryChecker"
    priority = 1

    rule_label {
      name = "nsse:suspicious:request"
    }

    action {
      count {}
    }

    statement {
      not_statement {
        statement {
          geo_match_statement {
            country_codes = ["BR"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "00-CountryCheckerMetrics"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "01-AWSManagedRulesAmazonIpReputationList"
    priority = 2

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "01-AWSManagedRulesAmazonIpReputationListMetrics"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "02-AWSManagedRulesAnonymousIpList"
    priority = 3

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAnonymousIpList"
        vendor_name = "AWS"

      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "02-AWSManagedRulesAnonymousIpListMetrics"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "03-AWSManagedRulesSQLiRuleSet"
    priority = 4

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"

      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "03-AWSManagedRulesSQLiRuleSetMetrics"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "04-AWSManagedRulesBotControlRuleSet"
    priority = 5

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesBotControlRuleSet"
        vendor_name = "AWS"

      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "04-AWSManagedRulesBotControlRuleSetMetrics"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "05-AWSManagedRulesCommonRuleSet"
    priority = 6

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "05-AWSManagedRulesCommonRuleSetMetrics"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "98-SuspiciousRequestFlagger"
    priority = 98

    rule_label {
      name = "nsse:suspicious:request"
    }

    action {
      count {}
    }

    statement {
      label_match_statement {
        scope = "NAMESPACE"
        key   = "awswaf:managed:aws:"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "98-SuspiciousRequestFlaggerMetrics"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "99-CustomForbiddenResponse"
    priority = 99

    action {
      block {
        custom_response {
          response_code            = 403
          custom_response_body_key = "403-CustomForbiddenResponse"
        }
      }
    }

    statement {
      label_match_statement {
        scope = "LABEL"
        key   = "nsse:suspicious:request"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "99-CustomForbiddenResponseMetrics"
      sampled_requests_enabled   = true
    }
  }

  custom_response_body {
    key          = var.waf.custom_response_body.key
    content      = jsonencode({ message =var.waf.custom_response_body.content})
    content_type = var.waf.custom_response_body.content_type
  }

  visibility_config {
    cloudwatch_metrics_enabled = var.waf.visibility_config.cloudwatch_metrics_enabled
    metric_name                = var.waf.visibility_config.metric_name
    sampled_requests_enabled   = var.waf.visibility_config.sampled_requests_enabled
  }
}

