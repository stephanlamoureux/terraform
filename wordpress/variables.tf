variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "EC2 instance type"
}

variable "ami" {
  type        = string
  default     = "ami-0bf8e703278ea0245"
  description = "Amazon Linux 2022"
}

variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "eu-central-1"
}

variable "key_name" {
  type        = string
  default     = "stephan"
  description = "my permission file"
}
