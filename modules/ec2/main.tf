# Creates the ec2 instace
# The instnce is launched in the public subnet with a public ip address for access from the internet
resource "aws_instance" "ec2_instance" {
  ami                         = var.ami_id
  instance_type               = var.ec2_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [aws_security_group.sg_ec2_instance.id]
  associate_public_ip_address = true

  tags = {
    Name = "${var.environment}-instance"
  }
}

