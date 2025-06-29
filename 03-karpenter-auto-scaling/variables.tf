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