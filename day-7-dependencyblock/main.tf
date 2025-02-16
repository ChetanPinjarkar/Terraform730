resource "aws_instance" "linux" {
  ami           = "ami-0ddfba243cbee3768"
  instance_type = "t2.micro"
  key_name      = "aws2"
  tags = {
    Name = "linux"
  }
}

resource "aws_s3_bucket" "dependent" {
  bucket     = "chetankis3bucket"
  depends_on = [aws_instance.linux]
}