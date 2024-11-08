# Creacion de repositorio ECR
resource "aws_ecr_repository" "main" {

  name                 = lower("lider-app-${var.functionality}-${var.env}") 
  image_tag_mutability = "IMMUTABLE"
  force_delete         = var.force_delete

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = local.resource_tags
}

# Asignar politica a repositorio ECR
resource "aws_ecr_repository_policy" "main" {

  repository = aws_ecr_repository.main.id

  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "ECRInitialPolicyAccess",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload"
            ]
        }
    ]
}
EOF
}