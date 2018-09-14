# aws-codelab

# ECR
- Login: `$(aws ecr get-login --no-include-email --profile <profile>)`
- Build image: `docker build -t test .`
- Tag image: `docker tag test:latest <account-id>.dkr.ecr.eu-central-1.amazonaws.com/test:latest`
- Push image: `docker push <account-id>.dkr.ecr.eu-central-1.amazonaws.com/test:latest`
