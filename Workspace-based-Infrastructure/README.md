# Terraform Workspace-Based Infrastructure

This project uses Terraform workspaces to manage different environments (dev and prod) with a single configuration.

## Directory Structure

```
Workspace-based-Infrastructure/
├── main.tf                    # Main configuration file
├── variables.tf               # Variable definitions
├── outputs.tf                 # Output definitions
├── backend.tf                 # Backend configuration
├── terraform.tfvars.dev       # Variables for dev environment
├── terraform.tfvars.prod      # Variables for prod environment
├── setup/                     # Setup directory for backend resources
│   ├── main.tf                # Configuration for backend resources
│   └── variables.tf           # Variables for backend resources
└── README.md                  # This file
```

## Initial Setup

### Step 1: Create the Backend Resources

First, you need to create the S3 bucket that will be used for the Terraform backend:

```bash
# Navigate to the setup directory
cd setup

# Initialize Terraform
terraform init

# Apply the configuration to create the S3 bucket
terraform apply
```

### Step 2: Initialize the Main Configuration

Now, navigate back to the main directory and initialize Terraform with the new backend:

```bash
# Navigate back to the main directory
cd ..

# Initialize Terraform with the new backend
terraform init
```

## Using Workspaces

### Create Workspaces

Create the dev and prod workspaces:

```bash
# Create dev workspace
terraform workspace new dev

# Create prod workspace
terraform workspace new prod
```

### List Workspaces

List all available workspaces:

```bash
terraform workspace list
```

### Switch Between Workspaces

Switch to a specific workspace:

```bash
# Switch to dev workspace
terraform workspace select dev

# Switch to prod workspace
terraform workspace select prod
```

### Check Current Workspace

Check the currently selected workspace:

```bash
terraform workspace show
```

## Deploying Infrastructure

### Deploy Dev Environment

```bash
# Switch to dev workspace
terraform workspace select dev

# Plan with dev variables
terraform plan -var-file="terraform.tfvars.dev"

# Apply with dev variables
terraform apply -var-file="terraform.tfvars.dev"
```

### Deploy Prod Environment

```bash
# Switch to prod workspace
terraform workspace select prod

# Plan with prod variables
terraform plan -var-file="terraform.tfvars.prod"

# Apply with prod variables
terraform apply -var-file="terraform.tfvars.prod"
```

## Key Differences Between Environments

- **Instance Types**: dev uses `t3.micro`, prod uses `t3.medium`
- **AutoScaling**: dev has 2-6 instances, prod has 4-10 instances
- **RDS**: dev uses `db.t3.micro`, prod uses `db.t3.medium`
- **Storage**: dev has 20GB, prod has 100GB
- **Backup Retention**: dev has 7 days, prod has 30 days
- **Deletion Protection**: Disabled for dev, enabled for prod

## Backend Configuration

The backend configuration uses an S3 bucket with:
- Bucket name: `multi-az-vpc-workspace-terraform-state`
- State encryption: Enabled
- State locking: Enabled (requires Terraform 1.1.0+)
- Workspaces support: Each workspace has its own state file

## Resource Naming

All resources include the workspace name in their identifiers:
- VPC: `${project_name}-${workspace}-vpc`
- RDS: `${project_name}-${workspace}-db`
- ALB: `${project_name}-${workspace}-alb`
- ASG: `${project_name}-${workspace}-asg`

## Tags

All resources are tagged with:
- Environment: Workspace name (dev/prod)
- Project: Project name

## Best Practices

1. Always check the current workspace before making changes
2. Use different variable files for each environment
3. Consider using `-target` for specific resources when testing
4. Enable state locking to prevent conflicts
5. Regularly backup your state files
6. Use `terraform plan` before `terraform apply`

## Troubleshooting

### Workspace Issues
- If you can't switch workspaces, make sure there are no locked states
- Use `terraform force-unlock LOCK_ID` if needed (with caution)

### Backend Issues
- Ensure the S3 bucket exists before initializing
- Check AWS credentials and permissions
- Verify the bucket name in backend.tf matches the created bucket

### State Issues
- If state is corrupted, you can restore from a previous version
- Use `terraform state pull` to backup your state file locally