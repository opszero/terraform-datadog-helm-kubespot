resource "helm_release" "datadog" {
  namespace        = "datadog"
  create_namespace = true

  name       = "datadog"
  repository = "https://helm.datadoghq.com"
  chart      = "datadog-operator"

  values = [
    "${file("${path.module}/datadog-values.yaml")}"
  ]
}

resource "kubernetes_manifest" "datadog_agent" {
  manifest = {
    apiVersion = "datadoghq.com/v2alpha1"
    kind       = "DatadogAgent"

    metadata = {
      name      = "datadog"
      namespace = "datadog"
    }

    spec = {
      features = {
        apm = {
          enabled = true

          hostPortConfig = {
            enabled = true
          }

          instrumentation = {
            enabled = true
          }

          unixDomainSocketConfig = {
            enabled = true
          }
        }

        dogstatsd = {
          hostPortConfig = {
            enabled = true
          }
        }

        externalMetricsServer = {
          enabled = true
        }

        kubeStateMetricsCore = {
          enabled = true
        }

        liveContainerCollection = {
          enabled = true
        }

        liveProcessCollection = {
          enabled = true
        }

        logCollection = {
          containerCollectAll = true
          enabled             = true
        }

        npm = {
          enabled = true
        }

        orchestratorExplorer = {
          enabled = true
        }
      }

      global = {
        credentials = {
          apiKey = var.datadog_api_key
          appKey = var.datadog_app_key
        }

        site = "datadoghq.com"
      }
    }
  }

  depends_on = [
    helm_release.datadog
  ]
}
