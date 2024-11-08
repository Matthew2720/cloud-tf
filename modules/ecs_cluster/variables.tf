################################################################################
# VARIABLES GLOBALES
################################################################################
variable "env" {
  description = "Ambiente donde será desplegado el componente. Sus únicos valores posibles serán: dev, qa, pdn"
  type        = string
  validation {
    condition     = contains(["dev", "qa", "pdn"], var.env)
    error_message = "El ambiente seleccionado no es valido, solo esta permitido: dev, qa, pdn"
  }
  nullable = false
}

variable "tags" {
  description = "Tags adicionales para aplicar a los recursos creados."
  type        = map(string)
  default     = null
  nullable    = true
}

variable "functionality" {
  description = "Nombre de la aplicación en la que se esta trabajando."
  type        = string
  nullable    = false
}


################################################################################
# VARIABLES ESPECIFICAS
################################################################################

variable "ecs_cluster_name" {
  description = "Nombre cluster ECS"
  type        = string
}

variable "alb-name"{
    type = string
    description = "Nombre del ALB"
}

variable "task-execution-role-name"{
    type = string
    description = "Nombre de la política de Task Execution"
}

variable "vpc_id"{
    type = string
    description = "VPC"
}

variable "availability_zones"{
    type = list(string)
    description = "List of AZs"
}

variable "subnets" {
  type = list(string)
  description = "List of subnets"
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
