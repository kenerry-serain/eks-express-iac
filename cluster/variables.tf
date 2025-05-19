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

variable "eks_cluster" {
  type = object({
    name                      = string
    role_name                 = string
    version                   = string
    enabled_cluster_log_types = list(string)
    access_config = object({
      authentication_mode = string
    })
    node_group = object({
      name           = string
      role_name      = string
      instance_types = list(string)
      capacity_type  = string
      ami_type       = string
      scaling_config = object({
        desired_size = number
        max_size     = number
        min_size     = number
      })
    })
  })

  default = {
    name                      = "eks-express-cluster"
    role_name                 = "eks-express-cluster-role"
    version                   = "1.32"
    enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
    access_config = {
      authentication_mode = "API_AND_CONFIG_MAP"
    }
    node_group = {
      name           = "eks-express-node-group"
      role_name      = "eks-express-node-group-role"
      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
      ami_type       = "AL2023_x86_64_STANDARD"
      scaling_config = {
        desired_size = 3
        max_size     = 3
        min_size     = 3
      }
    }
  }
}
