terraform {
  backend "s3" {
    bucket = "vpro-terraform-state"
    key = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "vpro-state-lock"
  }
}