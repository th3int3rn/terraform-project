# The security group is set up to control traffic to and from the instance.
# Defines the rules for ingress and egress traffic.
# Allows SSh traffic on port 22 and Http traffic on port 80
# The egress traffic allows all outbound traffic
resource "aws_security_group" "sg_ec2_instance" {
  name   = "${var.environment}-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  ingress {
    description = "Allow Http"
    from_port   = 80
    to_port     = 80
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