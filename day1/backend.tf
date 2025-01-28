terraform {
  backend "s3" {
    bucket = "tfkibucket"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
