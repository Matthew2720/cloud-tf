output "task_definition_role" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_cluster" {
  value = aws_ecs_cluster.cluster_ecs.id
}

output "load_balancer_sg"{
    value = aws_security_group.load_balancer_security_group.id
}

output "app_load_balancer" {
  value = aws_alb.application_load_balancer.arn
}