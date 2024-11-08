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

#ECR

variable "force_delete" {
  description = "Eliminar forzadamente el repositorio."
  type        = bool
  default     = false
  nullable    = false
}

#ECS

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

#VPC

variable "cidr_block"{
    type = string
    description = "CIDR block"
}

variable "availability_zones"{
    type = list(string)
    description = "AZs that are going to serve in VPC"
}

#S3 static page

variable "bucket_name" {
  type = string
  description = "Bucket name"
}

variable "oac-name" {
  type = string
  description = "OAC name"
}

#Aurora

variable "rds_sg_name" {
  type = string
  description = "Nombre del grupo de seguridad para acceso al RDS"
}

variable "cluster_name" {
  type = string
  description = "Nombre del cluster Aurora RDS"
}

variable "cluster_engine" {
  type = string
  description = "Motor de BD a usar."
}

variable "instance_name" {
  type = string
  description = "Nombre identificador de la instancia RDS"
}

variable "instance_class" {
  type = string
  description = "Tipo de instancia RDS"
}

variable "db_username" {
  type = string
  description = "Nombre de usuario BD"
}

variable "db_password" {
  type = string
  description = "Password para acceder a la BD"
}

variable "db_name" {
  type = string
  description = "Nombre de la base de datos para la conexión"
}