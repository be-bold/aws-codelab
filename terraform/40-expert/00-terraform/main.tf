// uses AWS_PROFILE and AWS_REGION
provider "aws" {
  version = "1.42"
}

// Initially you must comment this section to setup terraform state bucket and locking.
// After creation uncomment and run 'init.sh' while accepting that terraform will copy the state to the backend.
// See README for setp-by-step guide
terraform {
  backend "s3" {
    // uses AWS_PROFILE and AWS_DEFAULT_REGION
    bucket = "biz-kommitment-team1-terraform-state-eu-central-1"
    key = "terraform.tfstate"
    // if you use s3 bucket encryption, set encrypt = false to avoid encryption with AES instead of your KMS key
    encrypt = false
    dynamodb_table = "team1-terraform-state-lock"
  }
}