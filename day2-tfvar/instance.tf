resource "aws_instance" "dev" {
    ami = var.amiid
    instance_type = var.i_type
    key_name = var.key_name
}