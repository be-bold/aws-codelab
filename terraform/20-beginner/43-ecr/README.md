# ECR - Elastic Container Registry

# Goal
We want to store our docker images in the registry of AWS (ECR) to pull and run them on our EC2 instances. 


## Task
0. Create a new folder `43-ecr`
0. Create an ecr repository, which stores the 10 newest images
    - A repository can store multiple versions (tags) of an docker image


## Hints
<details><summary>Show Hint 1</summary><p>

You need two new resources.
</p></details>


<details><summary>Show Hint 2</summary><p>

Resources: aws_ecr_repository, aws_ecr_lifecycle_policy
</p></details>
