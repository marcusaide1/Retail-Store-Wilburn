variable "project_name" {
  description = "Project name for all resources"
  default     = "project-bedrock"
}

variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "opentelemetry_enabled" {
  description = "Enable OpenTelemetry for EKS workloads"
  type        = bool
  default     = false
}

variable "istio_enabled" {
  description = "Enable Istio sidecar injection for namespaces"
  type        = bool
  default     = false
}

variable "container_image_overrides" {
  description = "Optional container image overrides for workloads"
  type = map(object({
    repository = string
    tag        = string
  }))
  default = {}
}

variable "environment_name" {
  description = "Environment name"
  type        = string
  default     = "project-bedrock"
}

