resource "aws_instance" "appserver" {
  ami           = "ami-06dd92ecc74fdfb36"
  instance_type = "t2.micro"
  tags = {
    Name = "new terraform ec2"
  }
}

# resource "aws_s3_bucket" "app-media-store" {
#   bucket = "stephan-tf-bucket"
# }

# resource "aws_s3_bucket_ownership_controls" "example" {
#   bucket = aws_s3_bucket.app-media-store.id

#   rule {
#     object_ownership = "BucketOwnerEnforced"
#   }
# }

data "aws_s3_bucket" "demo_datasource_s3" {
  bucket = "stephan-tf-bucket"
}

output "data_source_demo_bucket_id" {
  value = data.aws_s3_bucket.demo_datasource_s3.id
}

data "aws_vpc" "my_default_vpc" {
  id = "vpc-0c0962cd47bd31248"
}

output "vpc_cidr_block" {
  value = data.aws_vpc.my_default_vpc.cidr_block
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-kernel-6.1-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"]
}

output "latest_ami" {
  value = data.aws_ami.amazon_linux.id
}
