# Production variables

environment          = "production"
region               = "eu-west-2"
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.10.0/24", "10.0.11.0/24"]
private_subnet_cidrs = ["10.0.12.0/24", "10.0.13.0/24"]
availability_zones   = ["eu-west-2a", "eu-west-2b"]
ami_id               = "ami-054a53dca63de757b" //FreeTier amazon linux
ec2_type             = "t3.medium"
db_name              = "db"
db_username          = "administrator"
db_password          = "Pa$$w0rd"
