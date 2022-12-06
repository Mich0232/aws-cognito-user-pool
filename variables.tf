variable "project_name" {
  type = string
}

variable "sso_domain" {
  type = string
}

variable "sso_domain_certificate_arn" {
  type = string
}

variable "callback_url" {
  type = string
}

variable "mfa" {
  type    = string
  default = "OPTIONAL"
}

variable "access_token_validity" {
  type        = number
  default     = 60
  description = "In minutes."
}

variable "refresh_token_validity" {
  type    = number
  default = 24

  description = "In hours."
}

variable "id_token_validity" {
  type        = number
  default     = 60
  description = "In minutes."
}

variable "tags" {
  type    = map(string)
  default = {}
}

locals {
  resource_tags = merge(var.tags, {
    Project = var.project_name
  })
}

