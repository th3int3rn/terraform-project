# terraform-project
.
└── terraform-project
    ├── environment
    │   ├── production.tfvars
    │   └── staging.tfvars
    ├── main.tf                         # Main entry point for the infrastructure
    ├── modules                         # Reusable Terraform modules
    │   ├── ec2
    │   │   ├── main.tf
    │   │   ├── sg.tf
    │   │   └── vars.tf
    │   ├── rds
    │   │   ├── main.tf
    │   │   ├── sg.tf
    │   │   └── vars.tf
    │   └── vpc
    │       ├── main.tf
    │       ├── nat.tf
    │       ├── outputs.tf
    │       └── vars.tf
    ├── README.md
    ├── terraform.tfstate
    ├── terraform.tfstate.backup
    └── vars.tf

## Prerequisities:

### 1. Configure AWS account
    Create a new user, add to the user specific policies for the resources that need to manage
        (i.e. Ec2FullAccess, VPCFullAccess, RDSFullAccess policies)
    Create access keys (IAM - Users - Create access keys)

### 2. Install AWS CLI (Ubuntu)
    sudo apt-get install awscli
    Configure credentials: aws configure

### 3. Install Terraform
    see https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
### 4. Initialize Git repository
    git init

## Commands to run Terraform project
    1. cd path/to/terraform-project
    2. Initialize Terraform project: terraform init
    3. Validate Configuration: terraform validate
    4. Rewrite Terraform configuration files to a canonical format: terraform fmt -diff 
    5. Check resources that Terraform will create, modify or destroy: terraform plan
        - In our case we have two environments with specific configuration
        - For Staging environment we need to run: terraform plan -var-file="environment/staging.tfvars"
        - For Production environment we need to run: terraform plan -var-file="environment/production.tfvars"
    6. For issues, we can check logs: 
        - TF_LOG=DEBUG terraform plan -var-file ="environment/staging.tfvars"
    7. After reviewing the output from "plan", we can apply changes to create resources to our AWS account
        - Staging: terraform apply -var-file="environment/staging.tfvars"
        - Production: terraform apply -var-file="environment/production.tfvars"
    8. When we are done, we can delete all resources created by Terraform:
        - Staging: terraform destroy -var-file="environment/staging.tfvars"
        - Production: terraform destroy -var-file="environment/production.tfvars"
    9. (Optional) Exporting Terraform plan to a file version of the plan for review
        - Staging: terraform plan -var-file="environment/staging.tfvars" -no-color > staging.txt
        - Production: terraform plan -var-file="environment/production.tfvars" -no-color > production.txt

## Best practice
    Store terraform.tfstate file in S3 bucket for a consistent way of managing state
    Steps:
        - Create S3 bucket and Dynamo db table in AWS
        - Configure S3 backend in Terraform
        ```
            terraform{
                backend "s3" {
                    bucket          = "name-of-the-bucket"
                    key             = "path/to/terraform.tfstate"
                    region          = "aws-region"
                    dynamodb_table  = "lock-table"
                }
            }
        ```