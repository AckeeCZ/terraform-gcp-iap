# Ackee Identity-Aware proxy provisioning Terraform module

## Indestructible google_iap_brand

Once created, `google_iap_brand` can not be destroyed, Terraform will successfuly run `terraform destroy` on this object, but when you try to recreate it, you have to run `terraform import`. You can get ID of existing IAP brand in GCP project using https://cloud.google.com/iap/docs/reference/rest/v1/projects.brands/list

This is also reason why we set `disable_on_destroy = false` on IAP API object (`google_project_service.iap`) - when we run destroy, API is disabled. So we must run `terraform apply` that fails (or enable API manually) and run `terraform import`
## Usage

```hcl
module "iap" {
  source                 = "git::ssh://git@gitlab.ack.ee/Infra/tf-module/iap.git?ref=v1.0.0"
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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | ~> 2.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_iap_brand.project_brand](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iap_brand) | resource |
| [google_iap_client.iap_clients](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iap_client) | resource |
| [google_iap_web_iam_policy.iam_allowed_users](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iap_web_iam_policy) | resource |
| [google_project_service.iap](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [kubernetes_secret.iap](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [google_iam_policy.iam_allowed_users](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/iam_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_users"></a> [allowed\_users](#input\_allowed\_users) | Users allowed to access IAP protected content | `list(string)` | `[]` | no |
| <a name="input_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#input\_cluster\_ca\_certificate) | CA certificate used to connect to Kubernetes cluster to store secret with IAP client credentials | `string` | n/a | yes |
| <a name="input_cluster_endpoint"></a> [cluster\_endpoint](#input\_cluster\_endpoint) | Kubernetes endpoint of cluster used to store secret with IAP client credentials | `string` | n/a | yes |
| <a name="input_cluster_token"></a> [cluster\_token](#input\_cluster\_token) | Cluster master token, keep always secret! | `string` | n/a | yes |
| <a name="input_iap_brand_name"></a> [iap\_brand\_name](#input\_iap\_brand\_name) | Name used in OAuth consent screen - will be shown to users when logging in | `string` | n/a | yes |
| <a name="input_iap_clients"></a> [iap\_clients](#input\_iap\_clients) | Map containing IAP client names as keys and Kubernetes cluster stage names as values | `map` | <pre>{<br>  "iap-test": "default",<br>  "iap-test-stage": "stage"<br>}</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | Default GCP zone | `string` | `"europe-west3-c"` | no |
| <a name="input_project"></a> [project](#input\_project) | GCP project name | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP region | `string` | `"europe-west3"` | no |
| <a name="input_support_email"></a> [support\_email](#input\_support\_email) | Support email used in OAuth consent screen - must be personal email or Google Group, that you are Owner of | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
