provider "aws" {

}

resource "aws_security_group" "allow_tls" {
  name        = "day7_sg"
  description = "Allow tls inbound traffic"
  dynamic "ingress" {
    for_each = [22, 80, 8080, 443, 9090, 3000, 9100, 81]
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

resource "aws_instance" "linux" {
  ami                    = "ami-0ddfba243cbee3768"
  instance_type          = "t2.micro"
  key_name               = "aws2"
  user_data              = file("test.sh")
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
  tags = {
    Name = "linux"
  }

}