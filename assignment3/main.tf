resource "aws_instance" "assignment3" {
  instance_type   = var.instance_type
  ami             = var.ami
  key_name        = "stephan"
  security_groups = [aws_security_group.my_security_group.name]
  user_data       = <<-EOF
                  #!/bin/bash
                  sudo yum update -y
                  sudo yum install -y httpd
                  # get public ip address of ec2 instance using instance metadata
                  TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` \
                  && REGION=`curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/region`
                  # get date and time of server
                  DATE_TIME=`date`
                  # set all permissions
                  chmod -R 777 /var/www/html
                  # create a custom index.html file
                  echo "<html>
                  <body>
                    <h1>This web server is launched from launch template to Learn DevOps</h1>
                    <p>This instance is created at <b>$DATE_TIME</b></p>
                    <p>This instance is running in <b>$REGION</b></p>
                  </body>
                  </html>" > /var/www/html/index.html
                  # start apache server
                  systemctl start httpd
                  systemctl enable httpd
                  EOF
  tags = {
    Name = "TFAssignment3"
  }
}

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
    Name = "Assignment3SecurityGroup"
  }
}

output "public_ip" {
  value = aws_instance.assignment3.public_ip
}
