provider "kubernetes" {
  version = "~> 1.13.0"

  load_config_file = false
  host             = "https://${var.cluster_endpoint}"
  token            = var.cluster_token

  cluster_ca_certificate = var.cluster_ca_certificate
}
