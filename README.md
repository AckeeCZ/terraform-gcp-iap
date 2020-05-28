# Ackee Identity-Aware proxy provisioning Terraform module

## Indestructible google_iap_brand

Once created, `google_iap_brand` can not be destroyed, Terraform will successfuly run `terraform destroy` on this object, but when you try to recreate it, you have to run `terraform import`. You can get ID of existing IAP brand in GCP project using https://cloud.google.com/iap/docs/reference/rest/v1/projects.brands/list

This is also reason why we set `disable_on_destroy = false` on IAP API object (`google_project_service.iap`) - when we run destroy, API is disabled. So we must run `terraform apply` that fails (or enable API manually) and run `terraform import`
## Usage

```hcl
module "iap" {
  source                 = "git::ssh://git@gitlab.ack.ee/Infra/tf-module/iap.git?ref=v6.4.0"
  namespace              = var.namespace
  project                = var.project
  region                 = var.region
  location               = var.zone
  cluster_ca_certificate = module.gke.cluster_ca_certificate
  cluster_user           = module.gke.cluster_username
  cluster_pass           = module.gke.cluster_password
  cluster_endpoint       = module.gke.endpoint
  iap_brand_name         = "My Company IAP-shielded app"
  support_email          = "my-company-iap-support-group@googlegroups.com"
  allowed_users = [
    "user:superadmin@example.com",
    "group:admins@example.com"
  ]
  iap_clients = {
    iap-test = "default"
    iap-test-stage = "stage"
  }
}
```

## Before you do anything in this module

Install pre-commit hooks by running following commands:

```shell script
brew install pre-commit terraform-docs
pre-commit install
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| kubernetes | ~> 1.11.0 |

## Providers

| Name | Version |
|------|---------|
| google | n/a |
| kubernetes | ~> 1.11.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_users | Users allowed to access IAP protected content | `list(string)` | `[]` | no |
| cluster\_ca\_certificate | CA certificate used to connect to Kubernetes cluster to store secret with IAP client credentials | `string` | n/a | yes |
| cluster\_endpoint | Kubernetes endpoint of cluster used to store secret with IAP client credentials | `string` | n/a | yes |
| cluster\_pass | Password used to connect to Kubernetes cluster to store secret with IAP client credentials | `string` | n/a | yes |
| cluster\_user | User used to connect to Kubernetes cluster to store secret with IAP client credentials | `string` | n/a | yes |
| iap\_brand\_name | Name used in OAuth consent screen - will be shown to users when logging in | `string` | n/a | yes |
| iap\_clients | Map containing IAP client names as keys and Kubernetes cluster stage names as values | `map` | <pre>{<br>  "hejda_iap_taky": "stage",<br>  "hejda_iap_test": "stage"<br>}</pre> | no |
| location | Default GCP zone | `string` | `"europe-west3-c"` | no |
| namespace | Kubernetes namespace name in cluster used to store secret with IAP client credentials | `string` | n/a | yes |
| project | GCP project name | `string` | n/a | yes |
| region | GCP region | `string` | `"europe-west3"` | no |
| support\_email | Support email used in OAuth consent screen - must be personal email or Google Group, that you are Owner of | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
