# Create Public Server

resource "aws_instance" "bastion" {
  instance_type               = "t2.micro"
  ami                         = "ami-0ddfba243cbee3768"
  key_name                    = "aws2"
  vpc_security_group_ids      = [aws_security_group.allow_tls.id]
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  tags = {
    Name = "Bastion Node"
  }
}

# Create Private server