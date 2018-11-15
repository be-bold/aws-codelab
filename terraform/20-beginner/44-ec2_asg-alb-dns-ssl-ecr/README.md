# EC2 - ASG (Auto-Scaling Group) with Application Load Balancer (ALB) via DNS with SSL running a Docker Image from ECR (Elastic Container Registry)

# Goal
We want to pull a docker image from ECR and run it on our EC2 instances.


## Task
0. Build on task *ec2_asg-alb-dns-ssl*
0. Change the [user-data.sh](user-data.sh)
    - to login to ECR
    - to pull the docker image and run it exposing port 80
0. Allow EC2 instance to assume an IAM role (get inspired by [iam.tf](iam.tf))
    - Create a new file `iam.tf`
    - Create an `aws_iam_instance_profile` and reference it as *iam_instance_profile* in your `aws_launch_template`
    - Create an `aws_iam_role` 
    - Allow the role to be assumed by the EC2 instance (`aws_iam_policy_document`)
0. Allow the EC2 instance to pull the docker image from ECR (get inspired by [iam-ecr.tf](iam-ecr.tf))
    - Create an `aws_iam_role_policy`, attach it to the role and allow via `aws_iam_policy_document`
        - to get the account id
        - to pull the docker image from ECR


## Hints
<details><summary>Show Hint 1</summary><p>

You need three new resources and two data sources (to write `aws_iam_policy_document`s).
</p></details>


<details><summary>Show Hint 2</summary><p>

Resources: aws_iam_instance_profile, aws_iam_role, aws_iam_role_policy<\br>
Data Sources: aws_iam_policy_document
</p></details>


<details><summary>Show Hint 3</summary><p>

It's complicated, so have a look at [user-data.sh](user-data.sh), [iam.tf](iam.tf), and [iam-ecr.tf](iam-ecr.tf)
</p></details>