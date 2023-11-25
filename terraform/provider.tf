terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.25.0"
    }
  }

  backend "s3" {
    bucket         = "salsabyte-tf-state"
    key            = "state/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "salsabyte-tf-lockid"
  }
}

provider "aws" {
  region = "us-east-1" 
}
