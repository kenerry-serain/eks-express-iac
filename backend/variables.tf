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

variable "remote_backend" {
  type = object({
    bucket = string,
    state_locking = object({
      dynamodb_table_name = string
      dynamodb_table_billing_mode = string
      dynamodb_table_hash_key = string
      dynamodb_table_hash_key_type = string
    })
  })

  default = {
    bucket = "eks-express-terraform-state-files"
    state_locking = {
      dynamodb_table_name = "eks-express-terraform-state-locking"
      dynamodb_table_billing_mode = "PAY_PER_REQUEST"
      dynamodb_table_hash_key = "LockID"
      dynamodb_table_hash_key_type = "S"
    }
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

