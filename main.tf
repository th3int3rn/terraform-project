# The entry point for setting up the infrastructure

# Terraform aws provider block
# This specifies that we are using AWS as provider for Terraform.
# It allows Terraform to manage AWS resources
provider "aws" {
  # I'm using here the credentials to authenticate with Aws account
  # But best practice for security are one of the following methods:
  # 1. Set the environment variables AWS_ACCESS_KEY and AWS_SECRET_KEY and EXPORT them
  # 2. store the credentials in /aws/credentials
  # 3. Utilise Secret manager or Vault
  access_key = "AWS_ACCESS_KEY"
  secret_key = "AWS_SECRET_KEY"
  region     = var.region
}

# This ensures that the correct version of Terraform is used when running the configuration
terraform {
  required_version = ">= 1.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

# The EC2 module is responsible for provisioning the EC2 instance that will run the application. 
# This instance is deployed in one of the public subnets created by the VPC module

module "ec2" {
  source           = "./modules/ec2"
  ami_id           = var.ami_id
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_ids[0]
  instance_type    = var.ec2_type
  environment      = var.environment
}

# The VPC module is responsible for creating a Virtual Private Cloud (VPC) along with public and private subnets.
module "vpc" {
  source               = "./modules/vpc"
  region               = var.region
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  environment          = var.environment
}

# The RDS module provisions a MySQL database using Amazon RDS
module "rds" {
  source              = "./modules/rds"
  vpc_id              = module.vpc.vpc_id
  allowed_cidr_blocks = module.vpc.private_subnet_cidrs
  private_subnet_ids  = module.vpc.private_subnet_ids
  db_name             = var.db_name
  db_username         = var.db_username
  db_password         = var.db_password
  environment         = var.environment
}

