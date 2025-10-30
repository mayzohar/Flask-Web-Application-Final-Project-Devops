resource "aws_ecr_repository" "my_ecr_repo" {
  name                 = "project-1"
  image_tag_mutability = "MUTABLE"           # Can be MUTABLE or IMMUTABLE

  image_scanning_configuration {
    scan_on_push = true # Enable image scanning on push
  }

  tags = {
    Project     = "MyApplication"
  }
}

output "ECR-repo-URL" {
    value       = aws_ecr_repository.my_ecr_repo.repository_url
    description = "The URL of the ECR repository"
}
