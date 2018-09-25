resource "aws_ecr_repository" "service1" {
  name = "${local.team_name}/products-service1"
}

resource "aws_ecr_lifecycle_policy" "service1" {
  repository = "${aws_ecr_repository.service1.name}"
  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 10,
            "description": "Keep last 5 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 5
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

// By default all IAM entities (incl. users) in your account have access,
// if they have the permissions to login, push and pull.
// Restrictions can be set via resource https://www.terraform.io/docs/providers/aws/r/ecr_repository_policy.html