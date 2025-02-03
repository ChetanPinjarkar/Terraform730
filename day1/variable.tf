variable "ami_id" {
  description = "inserting ami value to maint.tf"
  type        = string
  default     = "ami-00bb6a80f01f03502"

}
variable "type" {
  type    = string
  default = "t2.micro"

}
variable "keyname" {
  type    = string
  default = "aws2"

}