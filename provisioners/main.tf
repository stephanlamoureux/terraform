resource "aws_instance" "my_instance" {
  ami             = "ami-06dd92ecc74fdfb36"
  instance_type   = "t2.micro"
  key_name        = "stephan"
  security_groups = [aws_security_group.my_security_group.name]

  tags = {
    Name = "Ubuntu"
  }

  # Copy local shell script to instance
  provisioner "file" {
    source      = "./install_nginx.sh"
    destination = "/home/ubuntu/install_nginx.sh"
  }

  # Run the shell script
  provisioner "remote-exec" {
    inline = [
      "chmod +x ./install_nginx.sh",
      "./install_nginx.sh"
    ]
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("/home/steve/.ssh/stephan.pem")
    timeout     = "4m"
  }
}
