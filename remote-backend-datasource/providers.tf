terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.24.0"
    }
  }
  backend "s3" {
    bucket         = "tf-s3-state-32434587"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "tf_dynmodb_state_lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-central-1"
}
