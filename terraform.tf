terraform {

  cloud {
    organization = "abnormalend-terraform"
    workspaces {
      name = "necesse"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}