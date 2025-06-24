variable "aws_key_pair_name" {
  default = "terra-us-east-2"
}

variable "instance_ami_id" {
  default = "ami-0d1b5a8c13042c939"
}

variable "instance_root_volume" {
  default = "10"
  type    = number
}

variable "root_volume_type" {
  default = "gp3"
  type    = string

}
