variable "vpc_id" {

}

variable "private_subnet_ids" {
  description = "List of private subnets"
  type        = list(string)
}

variable "allowed_cidr_blocks" {
  description = "List of allowed ips"
  type        = list(string)
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "db"
}

variable "db_username" {
  description = "DAtabase username"
  type        = string
  default     = "administrator"
}

variable "db_password" {
  description = "Database password"
  type        = string
  default     = "admin123"
}

