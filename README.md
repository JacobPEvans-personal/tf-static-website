# tf-static-website

Terraform IaC that deploys the [jacobpevans.com](https://jacobpevans.com) static website to AWS. Provisions S3 (origin hosting), CloudFront (CDN + HTTPS), Route 53 (DNS), and ACM (SSL/TLS certificates). State is stored in an encrypted S3 backend.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.0
- AWS credentials configured (default profile or `AWS_PROFILE` env var)
- An existing Route 53 hosted zone for the target domain
- An S3 bucket for Terraform state (`jacobpevans-tf-states`)

## Setup

```bash
terraform init
```

Terraform will download the [`cloudmaniac/static-website/aws`](https://registry.terraform.io/modules/cloudmaniac/static-website/aws/latest) community module and configure the S3 remote backend.

## Usage

```bash
# Preview changes
terraform plan

# Apply infrastructure
terraform apply

# Destroy infrastructure
terraform destroy
```

Website source files live in `s3-files/`. After `terraform apply` succeeds, deploy site content to the S3 origin bucket using the AWS CLI or a CI pipeline.

## Architecture

| Resource | Purpose |
|---|---|
| S3 bucket | Static file origin |
| CloudFront | CDN, HTTPS termination |
| Route 53 | DNS (apex + www redirect) |
| ACM certificate | SSL/TLS (us-east-1) |

## License

[Apache 2.0](LICENSE)
