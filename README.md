# tf-static-website

Terraform Infrastructure as Code for deploying a static website to AWS. Provisions S3 (hosting), CloudFront (CDN), Route 53 (DNS), and ACM SSL/TLS certificates for HTTPS. Encrypted S3 backend for remote state management.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) >= 1.0
- AWS credentials configured (`~/.aws/credentials` or environment variables)
- AWS profile named `default` with appropriate IAM permissions

## Setup

```bash
terraform init
```

## Usage

Preview infrastructure changes:

```bash
terraform plan
```

Apply the infrastructure:

```bash
terraform apply
```

Tear down all resources:

```bash
terraform destroy
```

## Configuration

| Setting | Value |
|---|---|
| Primary domain | `jacobpevans.com` |
| Redirect domain | `www.jacobpevans.com` |
| State backend | S3 `jacobpevans-tf-states` / key `static-website` |
| Region | `us-east-1` |

This module uses [`cloudmaniac/static-website/aws`](https://registry.terraform.io/modules/cloudmaniac/static-website/aws) from the Terraform Registry.

## License

[Apache 2.0](LICENSE)
