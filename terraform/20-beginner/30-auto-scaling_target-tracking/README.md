# Auto-Scaling - Target Tracking

# Goal
If we measure high load on our service (e.g. cpu, memory, requests, ...), we want to scale out. 


## Task
0. Create a new folder `auto-scaling`
0. Create an autoscaling policy
    0. using scaling type *target tracking*
    0. predefined metric *ALBRequestCountPerTarget*
    


## Hints
<details><summary>Show Hint 1</summary><p>

You need three data sources and one resource.
</p></details>


<details><summary>Show Hint 2</summary><p>

Data Sources: aws_autoscaling_groups, aws_lb, aws_lb_target_group
Resources: aws_autoscaling_policy
</p></details>
