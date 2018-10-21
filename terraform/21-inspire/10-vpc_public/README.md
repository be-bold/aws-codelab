#VPC - Public


## Task
0. Create a new folder 10-vpc
0. Create a VPC 
    0. with three subnets (one per availability zone)
    0. with connection from/to the internet (Internet Gateway)
0. Use tags (team, vertical, environment) with all resources where possible

<details>
    <summary>##Hints</summary>
    0. You need 10 resources
    0. Resources: aws_vpc, aws_internet_gateway, aws_subnet, aws_route_table, aws_route, aws_route_table_association
</details>