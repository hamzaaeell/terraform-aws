# Terraform Backend Setup

This project uses an S3 bucket for Terraform state management.

## Terraform Version Requirements

- **Basic S3 Backend**: Works with all Terraform versions
- **S3 State Locking**: Requires Terraform 1.1.0 or later

## Initial Setup

### Step 1: Create the Backend Resources

First, you need to create the S3 bucket that will be used for the Terraform backend.

```bash
# Navigate to the setup directory
cd setup

# Initialize Terraform
terraform init

# Apply the configuration to create the backend resources
terraform apply

# Note the output (s3_bucket_name)
# This will be used in the backend configuration
```

### Step 2: Configure the Backend

After creating the backend resources, the backend configuration in `backend.tf` is already set up with the correct bucket name.

### Step 3: (Optional) Enable S3 State Locking

If you're using Terraform 1.1.0 or later, you can enable S3 state locking:

1. Open the `backend.tf` file
2. Uncomment the `use_lockfile = true` line
3. Save the file

### Step 4: Initialize the Main Configuration

Now, navigate back to the main directory and initialize Terraform with the new backend:

```bash
# Navigate back to the main directory
cd ..

# Initialize Terraform with the new backend
# This will migrate your local state to the S3 bucket
terraform init

# When prompted, confirm that you want to migrate the state
```

## Backend Configuration Details

The backend configuration in `backend.tf` includes:

- **S3 Bucket**: Stores the Terraform state file
  - Bucket: `multi-az-vpc-dev-terraform-state`
  - Key: `terraform.tfstate`
  - Region: `us-east-1`
  - Encryption: Enabled (AES256)

## Security Features

The backend configuration includes several security features:

1. **State Encryption**: The state file is encrypted at rest in S3
2. **Versioning**: Keeps multiple versions of the state file
3. **No Public Access**: The S3 bucket blocks all public access
4. **State Locking** (Optional): Available with Terraform 1.1.0+ by uncommenting `use_lockfile = true` in backend.tf

## Working with the Remote Backend

Once the backend is configured:

1. **Any team member** can run `terraform init` to download the latest state
2. **State history** is maintained through S3 versioning
3. **State snapshots** are created before each operation
4. **Team collaboration** is enabled through remote state storage

## Troubleshooting

If you encounter any issues with the backend:

1. Ensure you have the necessary AWS permissions
2. Check that the S3 bucket exists
3. Verify the region configuration matches your AWS setup
4. Make sure your AWS credentials are properly configured

## Migrating from Local to Remote Backend

If you have an existing local state file:

1. Follow the setup steps above
2. Run `terraform init` in the main directory
3. Confirm the migration when prompted
4. Your local state will be backed up and migrated to S3

## Cleaning Up

If you need to destroy the backend resources:

```bash
# Navigate to the setup directory
cd setup

# Destroy the backend resources
terraform destroy

# Note: This will delete the S3 bucket
# Make sure to backup your state file before doing this