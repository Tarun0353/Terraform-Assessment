
variable "domain" {
  description = "The domain for the resource"
}

variable "environment" {
  description = "The environment for the resource"
  default     = "development"
}

variable "service_name" {
  description = "The name of the service"
  default     = random_string.service_name.result
}

variable "delimiter" {
  description = "The delimiter to use between the naming components"
  default     = "-"
}

variable "casing" {
  description = "The casing to use for the naming components"
  default     = "lower"
  validation {
    condition     = can(string.upper(var.casing)) || can(string.title(var.casing)) || can(string.lower(var.casing))
    error_message = "Invalid casing value. Allowed values are 'upper', 'title', or 'lower'"
  }
}

resource "random_string" "service_name" {
  length  = 8
  special = false
}

locals {
  domain_cased         = var.casing == "upper" ? upper(var.domain) : (var.casing == "title" ? title(var.domain) : var.domain)
  service_name_cased   = var.casing == "upper" ? upper(var.service_name) : (var.casing == "title" ? title(var.service_name) : var.service_name)
  environment_cased    = var.casing == "upper" ? upper(var.environment) : (var.casing == "title" ? title(var.environment) : var.environment)
}

output "name" {
  value = "${var.casing == "upper" ? upper("pbp") : (var.casing == "title" ? title("pbp") : "pbp")}${var.delimiter}${local.domain_cased}${var.delimiter}${local.service_name_cased}${var.delimiter}${local.environment_cased}"
}

//Code:users can now customize the delimiter and casing used in their resource names, making the module more flexible and versatile.
