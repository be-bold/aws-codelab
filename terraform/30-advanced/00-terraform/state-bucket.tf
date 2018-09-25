# S3 bucket to hold terraform state files
# Remote State concept: https://www.terraform.io/docs/state/remote.html
# Backend concept: https://www.terraform.io/docs/backends/types/s3.html


resource "aws_s3_bucket" "this" {
  bucket = "biz-kommitment-advanced-${local.basename}-terraform-state-${local.region}"
  versioning {
    enabled = true
  }

  // all unencrypted objects will be encrypted by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_alias.this.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = "${local.default_tags}"
}

resource "aws_kms_key" "this" {
  tags = "${merge(local.default_tags, map("Name", "terraform-state-bucket-kms-key"))}"
}

resource "aws_kms_alias" "this" {
  target_key_id = "${aws_kms_key.this.id}"
  name = "alias/${local.basename}-terraform-state-bucket-key"
}