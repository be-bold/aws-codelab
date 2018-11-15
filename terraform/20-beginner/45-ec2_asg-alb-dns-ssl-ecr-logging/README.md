# EC2 - ASG (Auto-Scaling Group) with Application Load Balancer (ALB) via DNS with SSL running a Docker Image from ECR (Elastic Container Registry) with CloudWatch Logging

# Goal
We want to see our logs in CloudWatch.


## Task
0. Build on task *ec2_asg-alb-dns-ssl-ecr*
0. Create a new file `logging.tf`
    - Create a log group
0. Run docker container with `awslogs` as log-driver ([user-data.sh](user-data.sh))
0. Allow EC2 instance to log to CloudWatch
    - Create a new file `iam-logging.tf` with `aws_iam_role_policy`


## Hints
<details><summary>Show Hint 1</summary><p>

You need one new resource and one new data sources (to write `aws_iam_policy_document`).
</p></details>


<details><summary>Show Hint 2</summary><p>

Resources: aws_iam_role_policy<\br>
Data Sources: aws_iam_policy_document
</p></details>


<details><summary>Show Hint 3</summary><p>

It's complicated, so have a look at [user-data.sh](user-data.sh) and [iam-logging.tf](iam-logging.tf)
</p></details>