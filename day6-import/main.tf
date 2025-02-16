resource "aws_instance" "name" {
  ami           = "ami-0ddfba243cbee3768"
  instance_type = "t2.micro"
  key_name      = "aws2"
  tags = {
    Name = "linux"
  }

}

#terraform import aws_instance.name <i-0799bc74e2a07a611>