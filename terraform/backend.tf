terraform {
  backend "s3" {
    bucket = "gawdo"
    region = "us-east-1"
    key    = "eks/terraform.tfstate"
  }
}
