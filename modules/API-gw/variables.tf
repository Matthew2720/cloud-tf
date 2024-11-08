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

variable "get_item_lambda" {
  description = "Referencia al lambda que obtiene datos de una tabla"
  type = string
}

variable "post_item_lambda" {
  description = "Referencia al lambda que obtiene datos de una tabla"
  type = string
}


