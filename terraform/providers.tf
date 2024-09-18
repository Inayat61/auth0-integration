terraform {
  required_providers {
    auth0 = {
      source  = "auth0/auth0"
      version = "1.6.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # backend "s3" {
  #   bucket         = "auth0-integration-helloworld"
  #   key            = "terraform/state.tfstate"
  #   region         = "us-east-1"
  # }
}

provider "aws" {
  region = "us-east-1"
}

# terraform-client
provider "auth0" {
  domain        = var.auth0_domain
  client_id     = var.auth0_client_id
  client_secret = var.auth0_client_secret
}