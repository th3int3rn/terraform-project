resource "aws_db_instance" "mysql" {
  identifier             = "${var.environment}-mysql-db"
  engine                 = "mysql"
  instance_class         = "db.t3.micro"
  allocated_storage      = 10
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.id
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]
  multi_az               = true
  skip_final_snapshot    = true     # not take snapshot before delete
  publicly_accessible    = false    # ensure only resources in the allowed cidr can access

  tags = {
    Name = "${var.environment}-mysql-db"
  }
}
