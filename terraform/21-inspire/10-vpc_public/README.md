# VPC - Public


## Task
0. Create a new folder 10-vpc
0. Create a VPC 
    0. with vpc cidr block 172.16.0.0/16
    0. with three subnets: one per availability zone with cidr blocks
        0. 172.16.0.0/21
        0. 172.16.8.0/21
        0. 172.16.16.0/21
    0. with connection from/to the internet (Internet Gateway)
0. Use tags (team, vertical, environment) with all resources where possible


## Helpful
- [CIDR calculator](https://www.ipaddressguide.com/cidr)


## Hints
<details><summary>Show Hint 1</summary><p>

You need 10 resources
</p></details>


<details><summary>Show Hint 2</summary><p>

Resources: aws_vpc, aws_internet_gateway, aws_subnet, aws_route_table, aws_route, aws_route_table_association
</p></details>
