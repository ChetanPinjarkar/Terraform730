resource "aws_instance" "state-lock" {
  ami               = "ami-00bb6a80f01f03502"
  instance_type     = "t2.micro"
  key_name          = "aws2"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "Ubuntu-state-lock"
  }
}