terraform {
#  required_providers {
#    aws = {
#      source = "hashicorp/aws"
#    }
#  }
  backend "s3" {
    bucket  = "jacobpevans-tf-states"
    key     = "static-website"
    region  = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

# Enable bucket versioning
module "static-website" {
  source                  = "cloudmaniac/static-website/aws"
  version                 = "~> 1.0"
  website-domain-main     = "jacobpevans.com"
  website-domain-redirect = "www.jacobpevans.com"
}

