variable "ami_id" {
  description = "inserting ami value to maint.tf"
  type        = string
  default     = "ami-0b7207e48d1b6c06f"

}
variable "type" {
  type    = string
  default = "t2.micro"

}
variable "keyname" {
  type    = string
  default = "aws2"

}