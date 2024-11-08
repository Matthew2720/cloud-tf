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

variable "cidr_block"{
    type = string
    description = "CIDR block"
}

variable "availability_zones"{
    type = list(string)
    description = "AZs that are going to serve in VPC"
}

