resource "aws_security_group" "my_security_group" {
  name_prefix = "my-sg-"

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "all outbound traffic"
  }

  tags = {
    Name = "Assignment1SecurityGroup"
  }
}

resource "aws_instance" "my_instance" {
  ami             = "ami-06dd92ecc74fdfb36"
  instance_type   = "t2.micro"
  key_name        = "stephan"
  security_groups = [aws_security_group.my_security_group.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install apache2 -y
              sudo rm /var/www/html/index.html
              public_ip=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
              sudo echo "Hello $USER Your IP address is: $public_ip" > index.html
              sudo cp index.html /var/www/html
              sudo systemctl start apache2
              sudo systemctl enable apache2
              EOF

  tags = {
    Name = "TFAssignment1"
  }
}

output "public_ip" {
  value = aws_instance.my_instance.public_ip
}
