terraform {
  required_version = "~> 0.10"

  backend "s3" {
    key    = "nixos-live.tfstate"
    bucket = "chris-atkin-terraform-state"
    region = "eu-west-1"
  }
}

provider "aws" {
  region  = "eu-west-1"
  version = "~> 1.16"
}
