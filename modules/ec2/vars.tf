variable "ec2_type" {
  description = "Type of instance to start"
  type        = string
  default     = ""
}

variable "ami_id" {
  description = "ID of AMI to use for instance"
  type        = string
}

variable "vpc_id" {
  description = "The ID of VPC"
  type        = string
}

variable "public_subnet_id" {
  description = "The Id of the subnet"
  type        = string
}

variable "instance_type" {
  description = "Type of instance to start"
  type        = string
}

variable "environment" {
  description = "The name of the environment"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "List of allowed ips"
  default     = ["0.0.0.0/0"]
}