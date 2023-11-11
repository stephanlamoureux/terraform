resource "aws_instance" "assignment3" {
  instance_type        = var.instance_type
  ami                  = var.ami
  key_name             = var.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_s3_profile.name
  security_groups      = [aws_security_group.my_security_group.name]
  user_data            = file("${path.module}/user_data.sh")
  tags = {
    Name = "TFAssignment3"
  }
}

output "public_ip" {
  value = aws_instance.assignment3.public_ip
}

output "s3_bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}
