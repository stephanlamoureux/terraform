variable "ami" {
  type        = string
  description = "This variable holds the ami image id"
}

variable "app_region" {
  type    = string
  default = "eu-central-1"
}

variable "instance_type" {
  type    = string
  default = "$t2.micro"
}
