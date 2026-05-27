# CLAUDE.md — tf-static-website

## Project Overview

Terraform IaC for deploying [jacobpevans.com](https://jacobpevans.com) as a static website on AWS. Manages S3 (hosting), CloudFront (CDN), Route 53 (DNS), and ACM SSL/TLS. Remote state stored in an encrypted S3 backend.

## Key Files

| File | Purpose |
|------|---------|
| `main.tf` | Core Terraform configuration (providers, backend, module call) |
| `.terraform.lock.hcl` | Provider version lock file |
| `renovate.json` | Renovate dependency-update config (extends org presets) |
| `s3-files/` | Static website assets deployed to S3 (HTML, CSS, JS) |

## Common Commands

```bash
# Download providers and modules
terraform init

# Preview changes before applying
terraform plan

# Apply infrastructure changes
terraform apply

# Tear down all managed infrastructure
terraform destroy
```

## Architecture Notes

- **Module:** `cloudmaniac/static-website/aws` (Terraform Registry)
- **Primary domain:** `jacobpevans.com`
- **Redirect domain:** `www.jacobpevans.com`
- **State backend:** S3 bucket `jacobpevans-tf-states`, key `static-website`, region `us-east-1`, encrypted

## AWS Configuration

Uses the `default` AWS CLI profile in `us-east-1`. Ensure credentials are configured before running Terraform commands.

## Attribution Conventions

PRs modifying this repo should suffix the title with `[routine:daily-polish]` for automated documentation changes and include a Provenance block in the PR body.
