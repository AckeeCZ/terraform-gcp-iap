resource "google_project_service" "iap" {
  project            = var.project
  service            = "iap.googleapis.com"
  disable_on_destroy = false
}

resource "google_iap_brand" "project_brand" {
  support_email     = var.support_email
  application_title = var.iap_brand_name
  project           = google_project_service.iap.project
}

resource "google_iap_client" "iap_clients" {
  for_each = var.iap_clients

  display_name = each.key
  brand        = google_iap_brand.project_brand.name
}

resource "kubernetes_secret" "iap" {
  for_each = google_iap_client.iap_clients

  metadata {
    name      = each.value.display_name
    namespace = lookup(var.iap_clients, each.value.display_name)
  }

  data = {
    client_id     = each.value.client_id
    client_secret = each.value.secret
  }
}

data "google_iam_policy" "iam_allowed_users" {
  binding {
    role    = "roles/iap.httpsResourceAccessor"
    members = var.allowed_users
  }
}

resource "google_iap_web_iam_policy" "iam_allowed_users" {
  project     = var.project
  policy_data = data.google_iam_policy.iam_allowed_users.policy_data
}
