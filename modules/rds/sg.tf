# Controls access to the RDS instance, allowing traffic only from the ec2 instance
resource "aws_security_group" "rds_security_group" {
  name   = "${var.environment}-rds-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Ensures that the RDS instance is deployed across the private subnets for security.
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.environment}-rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.environment}-rds-subnet-group"
  }
}