terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.28.0"
    }
  }
}

provider "aws" {
  profile = "rbalde"

  default_tags {
    tags = {

      Enviroment = terraform.workspace
      Aplication = "test"
    }
  }
}
