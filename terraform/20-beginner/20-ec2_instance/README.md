# EC2 - Instance


## Task
0. Create a new folder `10-ec2`
0. Create an ec2 instance 
    - based on operating system [Amazon Linux 2 (AMI hvm x86_64 gp2)](https://aws.amazon.com/amazon-linux-2/release-notes/#Amazon_Linux_2_AMI_IDs)
    - with small instance type (e.g. t2.nano, t2.micro, t2.small)
0. Install nginx on start via `sudo amazon-linux-extras install nginx1.12`
0. Allow access from the internet (0.0.0.0/0) on port 80
0. Open the public ip in the browser
0. Test what happens if you terminate the instance in the web console
0. Advanced: Load current AMI via data source *aws_ami*


## Helpful
- [instance types](https://aws.amazon.com/ec2/instance-types/)


## Hints
<details><summary>Show Hint 1</summary><p>

Load *vpc_id* via data source *aws_vpc* and *subnet_id* via data source *aws_subnet_ids*.
</p></details>


<details><summary>Show Hint 2</summary><p>

You need at least two data sources and two resources.
</p></details>


<details><summary>Show Hint 3</summary><p>

Resources: aws_instance, aws_security_group
</p></details>


<details><summary>Show Hint 4</summary><p>

*user_data* can be loaded from separate file with: `"${file("user-data.sh")}"`
</p></details>