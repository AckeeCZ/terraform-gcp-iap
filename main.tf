locals {
  source_project = var.source_project != "" ? var.source_project : var.project
}

data "google_project" "source_project" {
  project_id = local.source_project
}

resource "google_project_service" "iap" {
  project            = local.source_project
  service            = "iap.googleapis.com"
  disable_on_destroy = false
}

resource "google_iap_brand" "project_brand" {
  project           = data.google_project.source_project.number
  support_email     = var.support_email
  application_title = var.iap_brand_name
}

resource "google_iap_client" "iap_clients" {
  for_each = toset(var.iap_clients)

  display_name = each.key
  brand        = google_iap_brand.project_brand.name
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
