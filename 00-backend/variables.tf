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

