provider "kubernetes" {
  version = "~> 1.13.0"

  load_config_file = false
  host             = "https://${var.cluster_endpoint}"

  username = var.cluster_user
  password = var.cluster_pass

  cluster_ca_certificate = var.cluster_ca_certificate
}
