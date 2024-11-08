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

variable "vpc_id"{
    type = string
    description = "VPC"
}

variable "subnets" {
  type = list(string)
  description = "List of subnets"
}

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

