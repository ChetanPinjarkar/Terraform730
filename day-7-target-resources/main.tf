resource "aws_instance" "Ubuntu" {
  ami           = ""
  instance_type = "t2.micro"
  key_name      = "aws2"
  tags = {
    Name = "Ubuntu"
  }
}

resource "aws_instance" "linux" {
  ami           = "ami-0ddfba243cbee3768"
  instance_type = "t2.micro"
  key_name      = "aws2"
  tags = {
    Name = "linux"
  }

}

#terraform plan -target=aws_instance.Ubuntu