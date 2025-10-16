# Terraform backend configuration
# Note: Before using this backend, you need to create the S3 bucket
# by running the setup configuration in the 'setup' directory first

# For Terraform 1.1.0+, you can enable S3 state locking by uncommenting the use_lockfile line
# For older versions, state locking is not available with S3 backend

terraform {
  backend "s3" {
    bucket         = "multi-az-vpc-dev-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    # S3 state locking enabled (Terraform 1.1.0+)
    use_lockfile   = true
  }
}