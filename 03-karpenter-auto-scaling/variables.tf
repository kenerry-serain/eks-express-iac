variable "region" {
  default = "us-east-1"
}

variable "assume_role" {
  type = object({
    role_arn    = string,
    external_id = string
  })

  default = {
    role_arn    = "arn:aws:iam::654654554686:role/DevOpsNaNuvemRole-9db671b2-c6ce-460c-9eb0-f27e903d0f9a"
    external_id = "f2ed091d-8d7d-46cb-be56-fb349d502cfb"
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

variable "karpenter" {
  type = object({
    controller_role_name =  string
    controller_policy_name = string
  })
  default = {
    controller_role_name = "KarpenterControllerRole"
    controller_policy_name = "KarpenterControllerPolicy"
  }
}