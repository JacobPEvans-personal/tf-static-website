terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = ">= 2.0"
    }
  }
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

data "aws_iam_policy_document" "lambda_edge_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "security_headers_lambda" {
  name               = "jacobpevans-security-headers-lambda"
  assume_role_policy = data.aws_iam_policy_document.lambda_edge_assume_role.json
}

resource "aws_iam_role_policy_attachment" "security_headers_lambda" {
  role       = aws_iam_role.security_headers_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

locals {
  security_headers_code = <<-JS
    'use strict';
    exports.handler = (event, context, callback) => {
      const response = event.Records[0].cf.response;
      const headers = response.headers;
      headers['x-frame-options']           = [{key: 'X-Frame-Options', value: 'DENY'}];
      headers['x-content-type-options']    = [{key: 'X-Content-Type-Options', value: 'nosniff'}];
      headers['x-xss-protection']          = [{key: 'X-XSS-Protection', value: '1; mode=block'}];
      headers['strict-transport-security'] = [{key: 'Strict-Transport-Security', value: 'max-age=31536000; includeSubDomains; preload'}];
      headers['content-security-policy']   = [{key: 'Content-Security-Policy', value: "default-src 'self'; img-src 'self' data:; style-src 'self' 'unsafe-inline'"}];
      callback(null, response);
    };
  JS
}

data "archive_file" "security_headers" {
  type        = "zip"
  output_path = "${path.module}/security_headers.zip"
  source {
    content  = local.security_headers_code
    filename = "index.js"
  }
}

resource "aws_lambda_function" "security_headers" {
  function_name    = "jacobpevans-security-headers"
  handler          = "index.handler"
  runtime          = "nodejs20.x"
  role             = aws_iam_role.security_headers_lambda.arn
  filename         = data.archive_file.security_headers.output_path
  source_code_hash = data.archive_file.security_headers.output_base64sha256
  publish          = true
}

module "static-website" {
  source  = "cloudmaniac/static-website/aws"
  version = "~> 1.0"
  website-domain-main                   = "jacobpevans.com"
  website-domain-redirect               = "www.jacobpevans.com"
  cloudfront_lambda_function_arn        = aws_lambda_function.security_headers.qualified_arn
  cloudfront_lambda_function_event_type = "viewer-response"
}