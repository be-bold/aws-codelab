# EC2 - ASG (Auto-Scaling Group) with Application Load Balancer (ALB)

# Goal
Run multiple instances and load balance application to avoid down times during failure and deployment.


## Task
0. Build on task *ec2_asg*
0. Create an application load balancer (ALB) in new file `alb.tf`
    - which listens on http port 80 
    - allows traffic on port 80 from the internet (0.0.0.0/0)
    - use a *default_action* of type *fixed-response* to return some text
    - open the ALB endpoint (see web console) in the browser to see your fixed-response
0. Create a target group in new file `alb-target-group.tf`
    - use http port 80 to map load balancer traffic to your instance
    - define a health check on `/service1/health` (as defined in nginx config)
0. Create a ALB listener rule in the file `alb-target-group.tf`
    - if request path matches `/service1/*` forward traffic to the target group
0. Make change to *aws_autoscaling_group*
    - Connect to target group via attribute *target_group_arns*
    - Set min_size = 1, max_size = 3, desired_capacity = 2 to allow load balancing between instances
    - Set min_elb_capacity = 2 to wait for this number of instances during deployment
    
    

## Helpful
- Speed up deployments: Set [deregistration_delay](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-target-groups.html#deregistration-delay) to 10 seconds on *aws_lb_target_group*


## Hints
<details><summary>Show Hint 1</summary><p>

ALB: You need three resources.
ALB Target Group: You need two resources. 
</p></details>


<details><summary>Show Hint 2</summary><p>

ALB: aws_security_group, aws_lb, aws_lb_listener
ALB Target Group: aws_lb_target_group, aws_lb_listener_rule
</p></details>


<details><summary>Show Hint 3</summary><p>

Condition for *aws_lb_listener_rule*:
```
  condition {
    field = "path-pattern"
    values = ["/service1/*"]
  }
```
</p></details>
