provider "aws" {
  region = "${var.region}"
  profile = "${var.profile}"
}

// Initially you must comment this section to setup terraform state bucket and locking.
// After creation uncomment and run 'terraform init' while accepting that terraform will copy the state to the backend.
terraform {
  backend "s3" {
    bucket = "biz-kommitment-team1-terraform-state-eu-central-1"
    key = "terraform.tfstate"
    encrypt = true
    region = "eu-central-1"
    profile = "marcel"
  }
}