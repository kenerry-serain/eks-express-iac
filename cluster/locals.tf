locals {
  bash_user_arn    = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/administrator"
  console_user_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_AdministratorAccess_a08e3792465d3f04"
}