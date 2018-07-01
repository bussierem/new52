// We will define variables here that will be used in other .tf scripts
variable "access_key" {} // You will need to input non-defaulted variables in the "apply" command
variable "secret_key" {} // You do this via `-var 'var_name=VALUE'`
variable "region" {
  default = "us-east-1"
}

// Variable Maps:
variable "amis" {
  type = "map"
  default = {
    "us-east-1" = "ami-b374d5a5"
    "us-west-2" = "ami-4b32be2b"
  }
}

// Output Variables
output "ip" {
  value = "${aws_eip.ip.public_ip}"
}
