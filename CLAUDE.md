# tf-static-website

Terraform IaC for deploying `jacobpevans.com` as a static website on AWS.

## Architecture

Uses the [`cloudmaniac/static-website/aws`](https://registry.terraform.io/modules/cloudmaniac/static-website/aws) community module, which provisions:
- S3 bucket for static file hosting
- CloudFront CDN distribution
- Route 53 DNS records for primary and redirect domains
- ACM SSL/TLS certificate (us-east-1, required by CloudFront)

Remote state: S3 bucket `jacobpevans-tf-states`, key `static-website`, region `us-east-1`.

## Common Tasks

- `terraform init` — initialize providers and backend
- `terraform plan` — preview changes
- `terraform apply` — apply changes
- `terraform destroy` — tear down all infrastructure

## Constraints

- Do not commit `.tfvars` files — may contain secrets
- The `.terraform.lock.hcl` file should be committed to lock provider versions
- Only modify `.tf` files and documentation (`*.md`)
