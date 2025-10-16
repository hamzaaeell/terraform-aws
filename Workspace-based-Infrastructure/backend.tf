terraform {
  backend "s3" {
    bucket         = "multi-az-vpc-workspace-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    use_lockfile   = true
      }
}