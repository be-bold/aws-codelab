# SSL

# Goal
A ssl certificate is created and verified for teamX.codelab.marcelboettcher.de 


## Task
0. Create a new folder `41-ssl`
0. Create a ssl certificate with Amazon Certificate Manager (ACM) 
    0. for teamX.codelab.marcelboettcher.de
    0. use `DNS` as validation method
    0. Open Amazon Certificate Manager in the web console and see the *pending* validation status
0. Create a Route53 record as described in the [terraform docs](https://www.terraform.io/docs/providers/aws/r/acm_certificate_validation.html)
0. Use resource aws_acm_certificate_validation to let terraform wait until validation was successful
0. Open Amazon Certificate Manager in the web console
    0. see the *issued* validation status
    0. see the instructions how to manually validate the domain: that is what we did with terraform


## Hints
<details><summary>Show Hint 1</summary><p>

You need three resources and one data source.
</p></details>


<details><summary>Show Hint 2</summary><p>

Data Source: aws_route53_zone
Resources: aws_acm_certificate, aws_route53_record, aws_acm_certificate_validation
</p></details>



