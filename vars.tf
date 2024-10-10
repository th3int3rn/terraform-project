variable "region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "eu-west-1"
}

variable "ami_id" {
  description = "ID of AMI to use for instance"
  type        = string
  # default = "ami-054a53dca63de757b"
}

variable "ec2_type" {
  description = "Type of instance to start"
  type        = string
  default     = "t2.micro"
}

variable "vpc_cidr" {
  description = "The IPv4 CIDR block for the VPC"
  type        = string
  #   default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR list of public subnet"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR list of private subnet"
  type        = list(string)
}

variable "availability_zones" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
}

variable "environment" {
  description = "The name of the environment"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
}