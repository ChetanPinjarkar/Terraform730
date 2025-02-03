resource "aws_security_group" "allow_tls" {
  name        = "Allow_tls"
  description = "Allow tls inbound traffic"
  dynamic "ingress" {
    for_each = [22, 80, 8080, 443]
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      //ipv6_cidr_blocks = ["::/0"]
    }
  }
  egress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "dev" {
  ami                    = var.ami_id
  instance_type          = var.type
  key_name               = var.keyname
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
  tags = {
    Name = "dev"
  }
}