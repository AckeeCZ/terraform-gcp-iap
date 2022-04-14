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

variable "source_project" {
  description = "In case your GCP project already use IAP setup somewhere, create new one and set it in this variable"
  type        = string
  default     = null
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
  description = "List containing IAP client names"
  type        = list(string)
  default     = []
}
