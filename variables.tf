variable "location" {
  description = "Default GCP zone"
  default     = "europe-west3-c"
  type        = string
}

variable "region" {
  description = "GCP region"
  default     = "europe-west3"
  type        = string
}

variable "project" {
  description = "GCP project name"
  type        = string
}

variable "cluster_endpoint" {
  description = "Kubernetes endpoint of cluster used to store secret with IAP client credentials"
  type        = string
}

variable "cluster_ca_certificate" {
  description = "CA certificate used to connect to Kubernetes cluster to store secret with IAP client credentials"
  type        = string
}

variable "cluster_user" {
  description = "User used to connect to Kubernetes cluster to store secret with IAP client credentials"
  type        = string
}

variable "cluster_pass" {
  description = "Password used to connect to Kubernetes cluster to store secret with IAP client credentials"
  type        = string
}

variable "iap_brand_name" {
  description = "Name used in OAuth consent screen - will be shown to users when logging in"
  type        = string
}

variable "support_email" {
  description = "Support email used in OAuth consent screen - must be personal email or Google Group, that you are Owner of"
  type        = string
}

variable "allowed_users" {
  description = "Users allowed to access IAP protected content"
  type        = list(string)
  default     = []
}

variable "iap_clients" {
  description = "Map containing IAP client names as keys and Kubernetes cluster stage names as values"
  type        = map
  default = {
    iap-test       = "default"
    iap-test-stage = "stage"
  }
}
