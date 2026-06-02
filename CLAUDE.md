# CLAUDE.md — tf-static-website

## Repository purpose

Terraform IaC for the jacobpevans.com static website on AWS (S3 + CloudFront + Route 53 + ACM). Single `main.tf` using the `cloudmaniac/static-website/aws` community module.

## Key constraints

- **Do not modify** `s3-files/` — those are the live website source files; changes deploy to production.
- **Do not modify** `.terraform.lock.hcl` manually; let `terraform init -upgrade` manage it.
- **State backend** is `s3://jacobpevans-tf-states/static-website` (us-east-1, encrypted). Never run `terraform state` commands without confirming with the repo owner.
- The `required_providers` block is intentionally commented out; the lock file pins provider versions instead.

## Common tasks

```bash
terraform init        # initialize / install modules
terraform validate    # lint HCL
terraform plan        # preview changes
terraform apply       # deploy
```

## Attribution conventions

- PR title suffix: `[routine:daily-polish]` for automated polish PRs
- Label automated PRs with `cloud-routine`
- Provenance block required in PR bodies for all automated changes
