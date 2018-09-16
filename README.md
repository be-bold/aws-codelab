aws-codelab
---

# Start developing
- copy env-vars.sh.template to env-vars.sh and define variables: `cp env-vars.sh.template env-vars.sh`
- env-vars.sh is not checked-in
- in each new shell run `source setup-development.sh` to set environment variables used by CI scripts

# Service1
- build and upload docker image: `./ci/build-and-upload-service1.sh`

# ECR
- Login: `$(aws ecr get-login --no-include-email --profile <profile>)`
- Build image: `docker build -t test .`
- Tag image: `docker tag test:latest <account-id>.dkr.ecr.eu-central-1.amazonaws.com/test:latest`
- Push image: `docker push <account-id>.dkr.ecr.eu-central-1.amazonaws.com/test:latest`
