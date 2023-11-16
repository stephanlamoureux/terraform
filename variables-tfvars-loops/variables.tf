variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "EC2 instance type"
}

variable "ami" {
  type        = string
  default     = "ami-0a485299eeb98b979"
  description = "Amazon Linux 2023"
}

variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "eu-central-1"
}

variable "key_name" {
  type        = string
  default     = "esteban"
  description = "my permission file"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "stephan-tf-assignment3"
}

variable "num_of_buckets" {
  default = 2
}
variable "iam_role_name" {
  description = "The name of the IAM role for EC2 S3 access"
  type        = string
  default     = "EC2S3AccessRole"
}

variable "iam_instance_profile_name" {
  description = "The name of the IAM instance profile for EC2"
  type        = string
  default     = "ec2-s3-access-profile"
}

variable "iam_policy_name" {
  description = "The name of the IAM policy for S3 access"
  type        = string
  default     = "S3AccessPolicy"
}
