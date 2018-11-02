aws-codelab
---

# Requirements
- Terraform >= v0.11.8
- Git


# Setup
- fork this repo
- replace 'team1' in all files with your team name
- set environment variables
  - copy env-vars.sh.template to env-vars.sh and define variables: `cp env-vars.sh.template env-vars.sh`
  - env-vars.sh is not checked-in
  - in each new shell run `source setup-development.sh` to set environment variables used by CI scripts
- Setup S3 as Terraform backend
  - go to `terraform/00-terraform`
  - comment backend in `main.tf` and run `./init.sh`
  - run `./deploy.sh`
  - uncomment backend in `main.tf` and run `./init.sh`
  - temporarily created `terraform.tfstate*` files can be deleted
- Setup tooling
  - go to `terraform/01-tooling`
  - run `./init.sh`
  - run `./deploy.sh`
- Setup vpc
  - go to `terraform/10-vpc`
  - run `./init.sh`
  - run `./deploy.sh develop|live`
- Setup fargate-service1
  - go to `application/service1`
  - run `./build-and-upload.sh latest`
  - go to `terraform/20-fargate-service1`
  - run `./init.sh`
  - run `./deploy.sh develop|live latest`
    

# Start developing
- in each new shell run `source setup-development.sh` to set environment variables used by CI scripts


# Service1
- build and upload docker image: `./ci/build-and-upload-service1.sh`


# ECR
- Login: `$(aws ecr get-login --no-include-email --profile <profile>)`
- Build image: `docker build -t test .`
- Tag image: `docker tag test:latest <account-id>.dkr.ecr.eu-central-1.amazonaws.com/test:latest`
- Push image: `docker push <account-id>.dkr.ecr.eu-central-1.amazonaws.com/test:latest`


# Auto-Scaling
- load test with `watch -n 1 "curl www.google.de"` or [wrk](https://github.com/wg/wrk)