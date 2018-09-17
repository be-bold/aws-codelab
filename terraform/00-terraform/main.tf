// uses AWS_PROFILE and AWS_REGION
provider "aws" {}

// Initially you must comment this section to setup terraform state bucket and locking.
// After creation uncomment and run 'terraform init' while accepting that terraform will copy the state to the backend.
terraform {
  backend "s3" {
    // uses AWS_PROFILE and AWS_DEFAULT_REGION
    bucket = "biz-kommitment-team1-terraform-state-eu-central-1"
    key = "terraform.tfstate"
    encrypt = true
    dynamodb_table = "team1-terraform-state-lock"
  }
}