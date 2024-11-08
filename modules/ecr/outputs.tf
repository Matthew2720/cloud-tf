output "ecr_repository_name" {
  value       = aws_ecr_repository.main.name
  description = "Nombre del repositorio ECR creado."
}

output "ecr_repository_url" {
  value       = aws_ecr_repository.main.repository_url
  description = "URL de repositorio ECR creado."
}