terraform {
  backend "s3" {
    bucket = "vpro-state-bucket"
    key = "terraform.tfstate"
    region = "us-east-1"
    use_lockfile = "vpro-state-lock"
  }
}