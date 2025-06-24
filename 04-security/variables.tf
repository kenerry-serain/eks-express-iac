variable "region" {
  default = "us-east-1"
}

variable "assume_role" {
  type = object({
    role_arn    = string,
    external_id = string
  })

  default = {
    role_arn    = "<YOUR_ROLE>"
    external_id = "<YOUR_EXTERNAL_ID>"
  }
}

variable "tags" {
  type = object({
    Project     = string
    Environment = string
  })

  default = {
    Project     = "eks-express",
    Environment = "production"
  }
}



variable "waf" {
  type = object({
    name  = string
    scope = string
    custom_response_body = object({
      key          = string
      content      = string
      content_type = string
    })
    visibility_config = object({
      cloudwatch_metrics_enabled = bool
      metric_name                = string
      sampled_requests_enabled   = bool
    })
  })

  default = {
    name  = "waf-eks-express-webacl"
    scope = "REGIONAL"
    custom_response_body = {
      key          = "403-CustomForbiddenResponse"
      content      = "You are not allowed to perform the action you requested."
      content_type = "APPLICATION_JSON"
    }
    visibility_config = {
      cloudwatch_metrics_enabled = true
      metric_name                = "waf-eks-express-webacl-metrics"
      sampled_requests_enabled   = true
    }
  }
}
