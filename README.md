# tf-static-website

Terraform IaC deploying [jacobpevans.com](https://jacobpevans.com) as a static website to AWS. Provisions S3 (hosting), CloudFront (CDN), Route 53 (DNS), and ACM SSL/TLS certificates for HTTPS. State managed in an encrypted S3 backend.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) >= 1.x
- AWS CLI configured with a `default` profile
- S3 bucket `jacobpevans-tf-states` provisioned for remote state

## Installation

```bash
terraform init
```

## Usage

```bash
# Preview changes
terraform plan

# Apply infrastructure
terraform apply
```

Domains managed by this configuration:

| Domain | Role |
|--------|------|
| `jacobpevans.com` | Primary |
| `www.jacobpevans.com` | Redirect → primary |

## Architecture

| Service | Purpose |
|---------|---------|
| S3 | Static file hosting |
| CloudFront | CDN and HTTPS termination |
| Route 53 | DNS |
| ACM | SSL/TLS certificates |

Module: [`cloudmaniac/static-website/aws`](https://registry.terraform.io/modules/cloudmaniac/static-website/aws)

## License

Apache 2.0 — see [LICENSE](LICENSE).
