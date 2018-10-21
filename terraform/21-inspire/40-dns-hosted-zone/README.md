# DNS Hosted Zone

# Goal
Service can be reached via http://teamX.codelab.marcelboettcher.de/service1/health 


## Task
0. Create a new folder `dns-hosted-zone`
0. Create a hosted zone for `teamX.codelab.marcelboettcher.de`
0. Add NS records of your hosted zone (see web console in service Route53) as record in [aws-dns](https://github.com/marcelboettcher/aws-dns)
    0. clone git repository
    0. copy file `team1.tf` and change your NS records
    0. commit and push it


## Hints
<details><summary>Show Hint 1</summary><p>

You need one resource.
</p></details>


<details><summary>Show Hint 2</summary><p>

Resources: aws_route53_zone
</p></details>



