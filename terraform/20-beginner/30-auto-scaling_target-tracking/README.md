# Auto-Scaling - Target Tracking

# Goal
If we measure high load on our service (e.g. cpu, memory, requests, ...), we want to scale out. 


## Task
0. Create a new folder `auto-scaling`
0. Create an autoscaling policy
    0. using scaling type *target tracking*
    0. predefined metric *ALBRequestCountPerTarget*
0. run a load test on your application to see it scale
    0. run in shell `watch -n 3 "curl -s http://your-alb-dns-name/service1/health"` or refresh site in browser
    0. Service should scale after 3 minutes of more than 10 request per minute
    0. watch web console: EC2 -> Load Balancing -> Target Groups -> Targets
    0. watch web console: EC2 -> Auto Scaling -> Auto Scaling Groups -> Instances and Activity History
    


## Hints
<details><summary>Show Hint 1</summary><p>

You need three data sources and one resource.
</p></details>


<details><summary>Show Hint 2</summary><p>

Data Sources: aws_autoscaling_groups, aws_lb, aws_lb_target_group
Resources: aws_autoscaling_policy
</p></details>
