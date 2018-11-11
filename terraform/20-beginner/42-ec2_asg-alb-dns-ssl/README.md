# EC2 - ASG (Auto-Scaling Group) with Application Load Balancer (ALB) via DNS with SSL

# Goal
Service can be reached securely via own domain: https://teamX.codelab.marcelboettcher.de/service1/health 


## Task
0. Build on task *ec2_asg-alb*
0. Create a new file `dns.tf`
    - Create an A record for teamX.codelab.marcelboettcher.de, which links via [Route53 alias](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resource-record-sets-choosing-alias-non-alias.html) (AWS concept, not DNS) to the load balancer
0. Adjust the security group of the load balancer to accept traffic on port 443 instead of 80
0. Adjust the load balancer listener to
    - listen on port 443 (HTTPS) instead of 80 (HTTP)
    - link the certificate your created via Amazon Certificate Manager (ACM) in the previous task
    - use the recommended [AWS SSL policy](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-security-policy-table.html) `ELBSecurityPolicy-2016-08`



## Hints
<details><summary>Show Hint 1</summary><p>

You need one new resource and two new data soruces.
</p></details>


<details><summary>Show Hint 2</summary><p>

Data Sources: aws_route53_zone, aws_acm_certificate
Resources: aws_route53_record
</p></details>


<details><summary>Show Hint 3</summary><p>

You need to adjust aws_lb_listener by setting
```
  port = 443
  protocol = "HTTPS"
  certificate_arn = "${data.aws_acm_certificate.this.arn}"
  ssl_policy = "ELBSecurityPolicy-2016-08"
```
</p></details>


<details><summary>Show Hint 4</summary><p>

Do **not** change the port and protocol of the aws_lb_target_group as the ssl is terminated at the load balancer.
We still use unencrypted traffic between load balancer and our targets (ec2 instances).
</p></details>
