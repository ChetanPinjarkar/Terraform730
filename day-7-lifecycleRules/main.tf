resource "aws_instance" "linux" {
  ami               = "ami-0ddfba243cbee3768"
  instance_type     = "t2.micro"
  key_name          = "aws2"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "linux"
  }

  # lifecycle {
  #   create_before_destroy = true #create first then delete
  # }
  # lifecycle {
  #   ignore_changes = [ tags, ]
  # }
  # lifecycle {
  #   prevent_destroy = true
  #     }
}