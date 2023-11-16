# Create an S3 Bucket.
resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "stephan-bucket-assignment2"

  tags = {
    Name = "Assignment2S3Bucket"
  }
}

# Upload a static HTML file to the S3 bucket.
resource "aws_s3_bucket_object" "html_file" {
  bucket = aws_s3_bucket.my_s3_bucket.id
  key    = "index.html"
  source = "./index.html"
}

# Create an EC2 instance with an Apache server. Replace the default index.html file with the custom one from S3.
resource "aws_instance" "my_instance" {
  ami             = "ami-06dd92ecc74fdfb36"
  instance_type   = "t2.micro"
  key_name        = "stephan"
  security_groups = [aws_security_group.my_security_group.name]
  # Attach an EC2 role that allows access to S3
  iam_instance_profile = "ec2_access_s3"
  # Make sure the html file is uploaded to S3 before the user_data script is ran.
  depends_on = [aws_s3_bucket_object.html_file]

  user_data = <<-EOF
              #!/bin/bash
              # Install packages
              sudo apt update -y && sudo apt upgrade -y && sudo apt install apache2 awscli -y

              # Config web server
              sudo rm /var/www/html/index.html
              sudo aws s3 cp s3://stephan-bucket-assignment2/index.html /var/www/html/
              sudo systemctl start --now apache2
              EOF

  tags = {
    Name = "TFAssignment2"
  }
}

resource "aws_security_group" "my_security_group" {
  name_prefix = "my-sg-"

  # Fully public inbound rules for SSH, HTTP, and HTTPS.
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "ssh"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "http"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "https"
  }

  # Fully public outbound rules.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "all outbound traffic"
  }

  tags = {
    Name = "Assignment2SecurityGroup"
  }
}

# Display the public IPv4 address of the instance.
output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.my_instance.public_ip
}

# Display the name of the S3 bucket.
output "s3_bucket_name" {
  value = aws_s3_bucket.my_s3_bucket.id
}
