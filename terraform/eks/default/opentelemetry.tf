resource "kubectl_manifest" "otel_instrumentation" {
  count = var.opentelemetry_enabled ? 1 : 0

  depends_on = [
    module.retail_app_eks
  ]

  yaml_body = yamlencode({
    apiVersion = "opentelemetry.io/v1alpha1"
    kind       = "Instrumentation"
    metadata = {
      name      = "default-instrumentation"
      namespace = module.retail_app_eks.adot_namespace
    }
    spec = {
      env = [
        {
          name  = "OTEL_SDK_DISABLED"
          value = "false"
        },
        {
          name  = "OTEL_EXPORTER_OTLP_PROTOCOL"
          value = "http/protobuf"
        },
        {
          name  = "OTEL_RESOURCE_PROVIDERS_AWS_ENABLED"
          value = "true"
        },
        {
          name  = "OTEL_METRICS_EXPORTER"
          value = "none"
        }
      ]
    }
  })
}

