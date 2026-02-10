variable "environment_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

locals {
  result = merge(var.tags, {
    "retail-store-sample-app:environment" = var.environment_name
    "MatricNumber"                        = "ALT/SOE/025/1539"
  })
}

output "result" {
  value = local.result
}
