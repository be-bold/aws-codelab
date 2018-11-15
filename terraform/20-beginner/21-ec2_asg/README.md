# EC2 - ASG (Auto-Scaling Group)

# Goal
Make application resilient: Start a new instance, if the current one fails.


## Task
0. Build on task *ec2_instance*
0. Use auto-scaling group instead of instance to start a single instance
0. Tag your instances with Name = teamX-web-server and team = teamX
0. Test what happens when you terminate the instance in the web console
0. Deployment
    - Change something in the user data and apply the changes. What happens?
    - Enable instant deployment by adding `${aws_launch_template.web_server.latest_version}` to the name of the *aws_autoscaling_group*
    - Avoid downtime by adding `lifecycle { create_before_destroy = true }` to the *aws_autoscaling_group*
0. Configure nginx to serve requests to /service1/health with http status code 200 ([See nginx configuration](user-data.sh))


## Hints
<details><summary>Show Hint 1</summary><p>

You need at least two data sources and three resources.
</p></details>


<details><summary>Show Hint 2</summary><p>

Resources: aws_launch_template, aws_autoscaling_group, aws_security_group
</p></details>


<details><summary>Show Hint 3: user_data</summary><p>

Attention: *aws_launch_template* needs user data encoded as base64: `"${base64encode(file("user-data.sh"))}"`
</p></details>


<details><summary>Show Hint 4: Tagging of EC2 Instances</summary><p>

To tag instances started by auto scaling group, you need this attribute on the *aws_launch_template*
```hcl-terraform
  tag_specifications {
    resource_type = "instance"
    tags {
      Name = "teamX-web-server"
    }
  }
```
</p></details>


<details><summary>Show Hint 5: Public IPs for EC2 instances</summary><p>

If your ec2 instances do not have a public ip, you must set attribute *map_public_ip_on_launch = true* on each public *aws_subnet*.
</p></details>


<details><summary>Show Hint 6: Subnets</summary><p>

The attribute for subnets at the *aws_auto_scaling_group* is called `vpc_zone_identifier = ["${data.aws_subnet_ids.public.ids}"]`.
</p></details>


  