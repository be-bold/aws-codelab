resource "aws_dynamodb_table" "this" {
  name = "${local.basename}-terraform-state-lock"
  read_capacity = 1
  write_capacity = 1
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = "${merge(local.default_tags, map("Name", "Terraform State Lock"))}"
}