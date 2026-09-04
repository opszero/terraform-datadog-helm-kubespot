variable "datadog_api_key" {
  description = "The Datadog API key"
  type        = string
}


variable "datadog_version" {
  default     = "2.25.0"
  description = "The version of the datadog helm chart"
}
