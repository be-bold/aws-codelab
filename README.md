AWS CodeLab
---

# Setup

## AWS CLI (Command Line Interface)
- Install [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/installing.html)
- Test installation 
  - run in shell / command line: `aws --version` 
  - should show version number without errors
- Possible problems
  - if command `aws` is not working, close shell and open a new one after installation 
  - Windows: if command `aws` is not available in shell, [add aws to your PATH variable](https://docs.aws.amazon.com/cli/latest/userguide/awscli-install-windows.html#awscli-install-windows-path)
  - if you have problems with the connection or certificates, avoid using your company proxy


## Setup AWS API Credentials
- run `aws configure --profile codelab-setup-test`
  - AWS Access Key ID: <send-to-you-by-email>
  - AWS Secret Access Key: <send-to-you-by-email>
  - Default region name: eu-central-1
  - Default output format: json
- you can find and edit your inputs in your home directory: `.aws/credentials` and `.aws/config`
  - Linux: e.g. `less ~/.aws/credentials`
- Test setup
  - run in your shell `aws ssm get-parameter --name /codelab/setup/test --profile codelab-setup-test`
  - should return a json output without errors
- Possible problems
  - "The config profile (codelab-setup-test) could not be found": check `.aws/credentials`
  ```
  [codelab-setup-test]
  aws_access_key_id     = <secret>
  aws_secret_access_key = <secret>
  ```
  - "Unable to locate credentials": try to set [environment variable](https://docs.aws.amazon.com/cli/latest/topic/config-vars.html#the-shared-credentials-file) `AWS_SHARED_CREDENTIALS_FILE=/your/path/.aws/credentials`


## Terraform
- Install newest [terraform](https://www.terraform.io/downloads.html) version 0.x
- Test installation
  - Test terraform command 
    - run in shell / command line: `terraform --version` 
    - should show version number without errors
  - Test terraform init
    - create an empty folder, create a file `main.tf` with [this content](terraform/00-setup-test/main.tf)
    - run `terraform init` in that folder
    - should download aws provider and report "Terraform has been successfully initialized!" 
  - Test terraform plan
    - run `terraform plan` in that folder
    - should succeed with "Plan: 1 to add, 0 to change, 0 to destroy."
- Possible problems
  - if command `terraform` is not working, close shell and open a new one after installation 
  - Windows: if command `terraform` is not available in shell, add terraform.exe to your PATH variable
  - if you have problems with the connection or certificates, avoid using your company proxy


## Git
- Optionally [install git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git), if you want to clone this code examples
- run in your workspace folder: `git clone git@github.com:marcelboettcher/aws-codelab.git`


## IDE (Integrated Development Environment)
- you can use any IDE or even a text editor
- but [IntelliJ IDEA](https://www.jetbrains.com/idea/) has syntax highlighting and auto-completion for terraform