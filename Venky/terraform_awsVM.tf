provider "aws" {
    region = var.vpc_region
}

terraform {
  backend "s3" {
    bucket = "devvbuck"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}
