terraform {
  backend "s3" {
    bucket = "gh-tf-ci-state"
    key = "environments/staging/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

