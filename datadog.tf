resource "helm_release" "datadog" {
  namespace        = "datadog"
  create_namespace = true

  name       = "datadog"
  repository = "https://helm.datadoghq.com"
  chart      = "datadog"
  version    = var.datadog_version


  values = [
    "${file("datadog-values.yaml")}"
  ]

  set = [
    {
      name  = "datadog.apiKey"
      value = var.datadog_api_key
    },
  ]
}
