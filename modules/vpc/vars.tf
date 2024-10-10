variable "region" {
  description = "Region in which AWS Resources to be created"
  type        = string
}

variable "vpc_cidr" {
  description = "The IPv4 CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "environment" {
  description = "The name of the environment"
  type        = string
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
